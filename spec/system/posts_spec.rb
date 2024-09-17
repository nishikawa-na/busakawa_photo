require 'rails_helper'

RSpec.describe "Posts", type: :system do
  before do
    driven_by(:rack_test)
  end

  describe "createアクション" do
    let(:user) { create(:user) }
    let(:post) { build(:post) }
    it "投稿のテスト" do
      login(user)
      click_link '投稿'
      fill_in "タイトル", with: post.title
      fill_in "説明", with: post.body
      attach_file "画像" , "spec/fixtures/image/post_test1.png"
      click_button '投稿する'
      expect(current_path).to eq posts_path
    end
  end
end