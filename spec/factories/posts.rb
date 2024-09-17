FactoryBot.define do
  factory :post do
    association :user
    title { "title" }
    body { "body" }
    images { [Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/image/post_test1.png')) ]}
  end
end
