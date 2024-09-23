require 'rails_helper'

RSpec.describe "Users", type: :system do
  describe "new/createアクション" do
    let(:user) { build(:user) }
    it "新規登録のテスト" do
      visit root_path
      click_link "新規登録"
      fill_in "ペット名", with: user.name
      attach_file "プロフィール画像", "spec/fixtures/image/profile_test2.png"
      fill_in "メールアドレス", with: user.email
      fill_in "パスワード", with: user.password
      fill_in "パスワード確認", with: user.password_confirmation
      click_button "送信"
      expect(page).to have_content 'アカウント作成しました'
    end
  end
  describe "destroyアクション" do
    let(:user) { create(:user) }
    it "アカウント削除のテスト" do
      login(user)
      click_link "ユーザー情報"
      click_link "アカウント削除"
      expect do
        expect(page.accept_confirm).to eq "削除しますか？"
        expect(page).to have_content "アカウントを削除しました"
      end
    end
  end
  describe "show/edit/updateアクション" do
    let(:user) { create(:user) }
    it "アカウント情報変更のテスト" do
      login(user)
      click_link "ユーザー情報"
      click_link "プロフィール"
      click_link "アカウント情報変更はこちら"
      expect(page).to have_content "アカウント編集"
      fill_in "ペット名", with: "pet_name"
      attach_file "プロフィール画像", "spec/fixtures/image/profile_test2.png"
      click_button "編集"
      expect(page).to have_content "ユーザー情報を更新しました"
    end
  end
  describe "postsアクション" do
    let(:user) { create(:user) }
    let!(:post) { create(:post, user:) }
    let!(:post_one) { create(:post, user:, title: "テストタイトル2") }
    let!(:post_not_current) { create(:post, title: "別ユーザーの投稿タイトル1") }
    it "ログインユーザーの投稿一覧表示" do
      login(user)
      click_link "ユーザー情報"
      click_link "投稿一覧"
      expect(page).to have_content post.title
      expect(page).to have_content post_one.title
    end
  end
  describe "like_postアクション" do
    let(:user) { create(:user) }
    let!(:post) { create(:post, title: "表示されないテストタイトル") }
    let!(:like_post) { create(:like_post, post:) }
    let!(:current_user_like_post) { create(:like_post, user:) }
    it "ログインユーザーのいいねした投稿一覧" do
      login(user)
      click_link "ユーザー情報"
      click_link "いいね一覧"
      expect(page).to have_link current_user_like_post.post.title
      expect(page).not_to have_link like_post.post.title
    end
  end
end
