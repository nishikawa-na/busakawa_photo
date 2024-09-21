require 'rails_helper'

RSpec.describe "UserSessions", type: :system do
  let(:user) { create(:user) }
  describe "new/createアクション" do
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
      expect(page).to have_content 'ログインしました'
    end
  end
  describe "destroyアクション" do
    it "ログアウト出来るか" do
      login(user)
      click_link "ユーザー情報"
      click_link "ログアウト"
      expect do
        expect(page.accept_confirm).to eq "ログアウトしますか？"
        expect(page).to have_content "ログアウトしました"
      end
    end
  end
end
