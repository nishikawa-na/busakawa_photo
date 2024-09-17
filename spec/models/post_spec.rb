require 'rails_helper'

RSpec.describe Post, type: :model do
  describe "createアクション" do
    let(:post) { create(:post) }
    context 'postsインスタンス作成' do
      it 'バリデーションエラーに引っかかっていないか' do
        expect(post).to be_valid
      end
      it '投稿のタイトルが空の場合、エラーが発生すること' do
        post.title = nil
        expect(post).to be_invalid
      end
      it '投稿のタイトルが2文字以下の場合、エラーが発生すること' do
        post.title = "a"
        expect(post).to be_invalid
      end
      it '投稿の説明が空の場合、エラーが発生すること' do
        post.body = nil
        expect(post).to be_invalid
      end
      it '投稿の説明が80文字以上の場合、エラーが発生すること' do
        post.body =  "a" * 81
        expect(post).to be_invalid
      end
      it '投稿の画像が空の場合、エラーが発生すること' do
        post.images = [ ]
        expect(post).to be_invalid
      end
      it '投稿の画像が5枚以上の場合、エラーが発生すること' do
        post.images = [
          Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/image/post_test1.png')),
          Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/image/post_test2.png')),
          Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/image/post_test3.png')),
          Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/image/post_test4.png')), 
          Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/image/profile_test1.png')),
          Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/image/profile_test2.png')) 
        ]
        expect(post).to be_invalid
      end
    end
  end
end
