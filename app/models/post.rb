class Post < ApplicationRecord
  has_attached_file :image, styles: { medium: "600x600>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
  
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  
  default_scope { order("created_at DESC") } 
  
  def liked_by?(user)
    likes.where(user_id: user.id).any?
  end
end
