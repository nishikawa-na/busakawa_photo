class Post < ApplicationRecord
  belongs_to :user
  validates :title, presence: true, length: { minimum: 2 }
  validates :body, presence: true, length: { maximum: 80 }
  validates :images, presence: true
  validate :check_count
  mount_uploaders :images, PostPhotoUploader
  has_many :comments, dependent: :destroy
  has_many :like_posts, dependent: :destroy
  has_many :post_counts, dependent: :destroy

  def check_count
    limit = 10
    if images.length >= limit
      errors.add(:post, "画像は#{limit}枚まで投稿可能です")
    end
  end

  def self.ransackable_attributes(auth_object = nil)
    ["title", "body"]
  end

  def self.ransackable_associations(auth_object = nil)
    []
  end

end
