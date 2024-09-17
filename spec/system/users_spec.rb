require 'rails_helper'

RSpec.describe "Users", type: :system do
  before do
    driven_by(:rack_test)
  end

  describe "createアクション" do
    let(:user) { build(:user) }
    it "新規登録のテスト" do
      visit root_path
      click_link "新規登録"
      fill_in "愛犬名", with: user.name
      attach_file "プロフィール画像" , "spec/fixtures/image/profile_test2.png"
      fill_in "メールアドレス", with: user.email
      fill_in "パスワード", with: user.password
      fill_in "パスワード確認", with: user.password_confirmation
      click_button "送信"
      expect(current_path).to eq line_official_path
    end
  end
  describe "destroyアクション" do
    let(:user) { create(:user) }
    it "アカウント削除のテスト" do
      login(user)
      click_link "アカウント削除"
      expect(current_path).to eq root_path
    end
  end
end
