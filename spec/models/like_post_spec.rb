require 'rails_helper'

RSpec.describe LikePost, type: :model do
  describe "createアクション" do
    let(:like_post) { create(:like_post) }
    let(:not_like_post) { create(:like_post) }

    context "like_postsインタンス作成" do
      it "バリデーションエラーが発生しないか" do
        expect(like_post).to be_valid
      end
      it "ユーザーIDと投稿IDがユニーク制約になっていないとエラーとなるか" do
        not_like_post.user = like_post.user
        not_like_post.post = like_post.post
        expect(not_like_post).to be_invalid
      end
    end
  end
end
