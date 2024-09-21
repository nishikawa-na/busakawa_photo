FactoryBot.define do
  factory :post_count do
    association :user
    association :post
  end
end
