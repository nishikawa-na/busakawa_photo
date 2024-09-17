require 'rails_helper'

RSpec.describe "UserSessions", type: :system do
  before do
    driven_by(:rack_test)
  end

  let(:user) { create(:user) }
  describe "createアクション" do
    it 'メールアドレスが異なる為、ログインできません' do
      visit login_path
      fill_in "email", with: "testo@example.com"
      fill_in "password", with: "12345"
      click_button "ログイン"
      expect(page).to have_content('ログインに失敗しました')
      expect(current_path).to eq login_path
    end
    it 'パスワードが異なる為、ログインできません'do
      visit login_path
      fill_in "email", with: user.email
      fill_in "password", with: "11111"
      click_button "ログイン"
      expect(page).to have_content('ログインに失敗しました')
      expect(current_path).to eq login_path
    end
    it 'ログイン出来るか' do
      visit login_path
      fill_in "email", with: user.email
      fill_in "password", with: "12345"
      click_button "ログイン"
      expect(current_path).to eq posts_path
    end
  end
  describe "destroyアクション" do
    it "ログアウト出来るか" do
      login(user)
      click_link "ユーザー情報"
      click_link "ログアウト"
      expect(current_path).to eq root_path
    end
  end
end
