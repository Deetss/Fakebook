class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
  has_many :relationships
       
  has_many :sent_requests, class_name: "Relationship",
                                  foreign_key: "requestee_id",
                                  dependent: :destroy
  has_many :rec_requests, class_name: "Relationship",
                                   foreign_key: "requested_id",
                                   dependent: :destroy
                                   
  has_many :req_friends, -> { where(accepted: true) }, class_name: "Relationship", foreign_key: :requestee_id
  has_many :rec_friends, -> { where(accepted: true) }, class_name: "Relationship", foreign_key: :requested_id
  
  has_many :posts
  has_many :likes
  has_many :comments
  
  def current_requests
    rec_requests.where(accepted: false)
  end
  
  def friends
    req_friends + rec_friends
  end
  
  def friends_list
    friends.map { |friend| User.find(friend_id(self, friend)) }
  end
  
  def friend_id(user, friend)
    friend.requestee_id == user.id ? friend.requested_id : friend.requestee_id
  end
  
  def friends_with?(other_user)
    friends.include?(other_user) unless self == other_user
  end
  
  def requested?(other_user)
    Relationship.where('requestee_id = ? AND requested_id = ? AND accepted = ? ', self, other_user, false).any? || Relationship.where('requestee_id = ? AND requested_id = ? AND accepted = ? ', other_user, self, false).any?
  end
  
  def feed(user = self)
    friend_ids = []
    friends.each do |friend|
      friend_ids << friend.requestee_id unless friend.requestee_id == id
      friend_ids << friend.requested_id unless friend.requested_id == id
    end
    Post.where("user_id IN (?) OR user_id = ?", friend_ids, id)
  end
end
