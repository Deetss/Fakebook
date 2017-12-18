class Post < ApplicationRecord
  belongs_to :user
  has_many :likes
  has_many :comments
  
  default_scope { order("created_at DESC") } 
  
  def liked_by?(user)
    likes.where(user_id: user.id).any?
  end
end
