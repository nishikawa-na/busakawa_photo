require 'rails_helper'

RSpec.describe "Relationships", type: :system do
  describe "createアクション" do
    let(:user) { create(:user) }
    let!(:post) { create(:post) }
    it "createアクション時にビューの一部が変更されるか" do
      login(user)
      visit post_path(post)
      click_link "フォロー"
      expect(page).to have_content "フォロー解除"
      click_link "ユーザー情報"
      click_link "フォロー一覧"
      expect(page).to have_content post.user.name
    end
    it "destroyアクション時にビューの一部が変更されるか" do
      login(user)
      visit post_path(post)
      click_link "フォロー"
      click_link "フォロー解除"
      click_link "ユーザー情報"
      click_link "フォロー一覧"
      expect(page).to_not have_content post.user.name
    end
  end
end
