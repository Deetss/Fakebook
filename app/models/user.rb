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
  has_many :posts
  has_many :likes
  
  def current_requests
    rec_requests.where(accepted: nil)
  end
  
  def friends
    Relationship.all.where('requested_id = ? AND accepted = true', self).or Relationship.all.where('requestee_id = ? AND accepted = true', self)
  end
  
  def friends_with?(other_user)
    friends.find_by(requested: other_user) || friends.find_by(requestee: other_user) unless self == other_user
  end
  
  def requested?(other_user)
    Relationship.all.where('requestee_id = ? OR requested_id = ?', self, self).any?
  end
  
  def feed
    friend_ids = []
    friends.each do |friend|
      friend_ids << friend.requestee_id unless friend.requestee_id == id
      friend_ids << friend.requested_id unless friend.requested_id == id
    end
    Post.where("user_id IN (?) OR user_id = ?", friend_ids, id)
  end
end
