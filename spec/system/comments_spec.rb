require 'rails_helper'

RSpec.describe "Comments", type: :system do
  describe "createアクション" do
    let!(:post) { create(:post) }
    let(:comment) { create(:comment)}
    it "createアクション後、コメントが表示されているか" do
      login(post.user)
      visit post_path(post)
      fill_in "コメント", with: "テストコメント"
      click_button "送信"
      expect(page).to have_content "テストコメント"
    end
    it "destroyアクション後、コメントが消えているか" do
      login(post.user)
      visit post_path(post)
      fill_in "コメント", with: "テストコメント"
      click_button "送信"
      find(".comment-delete").click
      expect do
        expect(page.accept_confirm).to eq "削除してよろしいですか？"
        expect(page).not_to have_content "テストコメント"
      end
    end
    it "コメント作成者以外削除ボタンを表示しない" do
      login(post.user)
      visit post_path(comment.post)
      expect(page).not_to have_selector ".comment-delete"
    end
  end
end
