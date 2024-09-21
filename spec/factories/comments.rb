FactoryBot.define do
  factory :comment do
    association :user
    association :post
    body { "コメント" }
  end
end
