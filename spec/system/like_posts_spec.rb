require 'rails_helper'

RSpec.describe "LikePosts", type: :system do
  describe "createアクション" do
    let(:user) { create(:user) }
    let!(:like_post) { create(:like_post) }
    it "createアクション後、投稿詳細画面でいいね数が増加しているか" do
      login(user)
      find(".bi.bi-heart").click
      visit post_path(like_post.post.id)
      expect(page).to have_content("いいね数 2")
    end
    it "createアクション実行時に一部のビューが変更されるか" do
      login(user)
      find(".bi.bi-heart").click
      expect(page).not_to have_content(".bi.bi-heart")
    end
  end
  describe "destroyアクション" do
    let(:user) { create(:user) }
    let!(:post) { create(:post, user:) }
    it "destroyアクション実行時に一部のビューが変更されるか" do
      login(user)
      find(".bi.bi-heart").click
      find(".bi.bi-heart-fill").click
      expect(page).not_to have_content(".bi.bi-heart-fill")
    end
  end
end
