FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password { "12345" }
    password_confirmation   { password }
    avatar { "profile_test1.png" }
    instagram_account_url { Faker::Internet.url }
    line_user_id  { SecureRandom.hex(5) }
    reset_password_token { SecureRandom.base64(5) }
  end
end
