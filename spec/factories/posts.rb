FactoryBot.define do
  factory :post do
    association :user
    title { "テストタイトル" }
    body { "テスト説明" }
    images { [Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/image/post_test1.png'))] }
  end
end
