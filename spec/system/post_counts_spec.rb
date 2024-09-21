require 'rails_helper'

RSpec.describe "PostCounts", type: :system do
  let(:user) { create(:user) }
  let!(:post_count) { create(:post_count) }
  it "投稿詳細ページに行く際にカウントされるか" do
    login(user)
    visit post_path(post_count.post)
    expect(page).to have_content "閲覧数 2"
  end
end
