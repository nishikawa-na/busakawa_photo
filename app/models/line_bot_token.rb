class LineBotToken < ApplicationRecord
  validates :line_user_id, presence: true
  validates :line_user_id_token, presence: true, uniqueness: true
end
