class User < ApplicationRecord
  authenticates_with_sorcery!
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, confirmation: true, length: { minimum: 5, maximum: 40 }, format: { with: /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i, message: 'は英数字の混合である必要があります' }, if: lambda {
    new_record? || changes[:crypted_password]
  } 
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }
  validates :reset_password_token, uniqueness: true, allow_nil: true
  validates :instagram_account_url, allow_blank: true, format: { with: %r{\Ahttps://(?:www\.)?instagram\.com/[a-zA-Z0-9._%+-]+(=[^&]*)?(\?.+)?\z} }
  validates :line_user_id, uniqueness: true, allow_nil: true

  mount_uploader :avatar, UserAvatarUploader
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :like_posts, dependent: :destroy
  has_many :my_like_posts, through: :like_posts, source: :post
  has_many :post_counts, dependent: :destroy
  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :followings, through: :relationships, source: :followed
  has_many :followers, through: :reverse_of_relationships, source: :follower
  has_many :authentications, dependent: :destroy
  accepts_nested_attributes_for :authentications

  def follow(user_id)
    relationships.create(followed_id: user_id)
  end

  def unfollow(user_id)
    relationships.find_by(followed_id: user_id).destroy
  end

  def following?(user)
    followings.include?(user)
  end

  def my_like_posts?(post)
    my_like_posts.include?(post)
  end
end