class Post < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  
  default_scope { order("created_at DESC") } 
  
  def liked_by?(user)
    likes.where(user_id: user.id).any?
  end
end
