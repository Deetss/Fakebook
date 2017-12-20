class User < ApplicationRecord
  after_create :send_welcome_email
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, omniauth_providers: %i[facebook]
  
  has_many :relationships
  has_many :sent_requests, class_name: "Relationship",
                                  foreign_key: "requestee_id",
                                  dependent: :destroy
  has_many :rec_requests, class_name: "Relationship",
                                   foreign_key: "requested_id",
                                   dependent: :destroy
  has_many :req_friends, -> { where(accepted: true) }, class_name: "Relationship", foreign_key: :requestee_id, dependent: :destroy
  has_many :rec_friends, -> { where(accepted: true) }, class_name: "Relationship", foreign_key: :requested_id, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  
  has_attached_file :picture, styles: {medium: "300x300>", thumb: "100x100>" }, default_url: "/images/missing.png"
  validates_attachment_content_type :picture, content_type: /\Aimage\/.*\z/
  
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
  
  private
  
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.name = auth.info.name   # assuming the user model has a name
      #user.picture = auth.info.image # assuming the user model has an image
      # If you are using confirmable and the provider(s) you use validate emails, 
      # uncomment the line below to skip the confirmation emails.
      # user.skip_confirmation!
    end
  end
  
  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end
  
  def send_welcome_email
    UserMailer.welcome_email(self).deliver_now
  end
end
