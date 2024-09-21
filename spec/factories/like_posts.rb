FactoryBot.define do
  factory :like_post do
    association :user
    association :post
  end
end
