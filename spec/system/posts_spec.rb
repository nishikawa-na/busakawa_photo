require 'rails_helper'

RSpec.describe "Posts", type: :system do
  describe "indexアクション" do
    let!(:user) { create(:user) }
    let!(:post) { create(:post, user: user) }
    let!(:post_1) { create(:post, user: user, title: "テストタイトル1", body: "テスト説明1") }
    it "投稿一覧が表示されているか" do
      visit posts_path
      expect do
        expect(page).to have_content "テストタイトル"
        expect(page).to have_content "テストタイトル1"
      end
    end
  end
  describe "new/createアクション" do
    let(:user) { create(:user) }
    let(:post) { build(:post) }
    it "投稿のテスト" do
      login(user)
      click_link '投稿'
      fill_in "タイトル", with: post.title
      fill_in "説明", with: post.body
      attach_file "画像" , "spec/fixtures/image/post_test1.png"
      click_button '投稿する'
      expect(page).to have_content '投稿作成しました'
    end
  end
  describe "destroyアクション" do
    let!(:user) { create(:user) }
    let!(:post) { create(:post, user: user) }
    it "投稿削除のテスト" do
      login(user)
      visit post_path(post)
      find(".post-delete").click
      expect do
        expect(page.accept_confirm).to eq "削除してよろしいですか？"
        expect(page).to have_content "投稿削除しました"
      end
    end
  end
  describe "edit/updateアクション" do
    let!(:user) { create(:user) }
    let!(:post) { create(:post, user: user) }
    it "投稿編集のテスト" do
      login(user)
      visit post_path(post)
      find(".bi.bi-pencil").click
      expect(page).to have_content "投稿編集"
      fill_in "タイトル", with: "テストタイトル2"
      fill_in "説明", with: "テスト説明2"
      attach_file "画像" , 'spec/fixtures/image/post_test1.png'
      click_button "編集"
      expect(page).to have_content "投稿編集しました"
    end
  end
  let(:user) { create(:user) }
  let(:post) { create(:post) }
    it "ログインユーザーと投稿作成ユーザーが異なる場合、編集削除ボタンが表示されない" do
      login(user)
      visit post_path(post)
      expect(page).not_to have_content (".bi.bi-trash")
    end
end