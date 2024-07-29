class Post < ApplicationRecord
  belongs_to :user
  has_many :photos, dependent: :destroy
  validates :title, presence: true, length: { minimum: 3 }
  validates :body, presence: true, length: { maximum: 50 }
end
