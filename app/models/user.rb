class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
       
  has_many :sent_requests, class_name: "Relationship",
                                  foreign_key: "requestee_id",
                                  dependent: :destroy
  has_many :rec_requests, class_name: "Relationship",
                                   foreign_key: "requested_id",
                                   dependent: :destroy
  
  def current_requests
    rec_requests.where(accepted: false)
  end
  
  def friends
    Relationship.all.where('requested_id = ? OR requestee_id = ? AND accepted = true', self, self)
  end
  
  def friends_with?(other_user)
    if friends.empty?
      false
    elsif friends.find_by(requestee: other_user) || friends.find_by(requested: other_user)
      true
    end
  end
  
  def requested?(other_user)
    Relationship.all.where('requestee_id = ? OR requested_id = ?', self, self).any?
  end
end
