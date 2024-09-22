require 'rails_helper'

RSpec.describe PostCount, type: :model do
  describe "createアクション" do
    let(:post_count) { create(:post_count) }
    let(:tomorrow_post_count) { create(:post_count, user: post_count.user, post: post_count.post, created_at: Time.zone.tomorrow.all_day) }
    context "post_countインスタンス作成" do
      it "バリデーションエラーが発生しないか" do
        expect(post_count).to be_valid
      end
      it "同じユーザーのカウント数は一日一回までである" do
        expect(tomorrow_post_count).to be_valid
      end
    end
  end
end
