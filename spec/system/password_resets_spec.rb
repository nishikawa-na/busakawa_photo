require 'rails_helper'

RSpec.describe "PasswordResets", type: :system do
  let(:user) { create(:user) }
  describe "new/edit/create/updateアクション" do
    it "パスワードが変更できるか" do
      login(user)
      click_link "ユーザー情報"
      click_link "パスワード変更"
      fill_in "email", with: user.email
      click_button "送信"
      expect(page).to have_content "メールを送信しました"
      visit edit_password_reset_path(user.reload.reset_password_token)
      fill_in 'パスワード', with: '123456789'
      fill_in 'パスワード確認', with: '123456789'
      click_button '送信'
      expect(page).to have_content "パスワードを変更しました"
    end
  end
end
