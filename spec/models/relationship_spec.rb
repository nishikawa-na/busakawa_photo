require 'rails_helper'

RSpec.describe Relationship, type: :model do
  describe 'createアクション' do
    context "relationshipインスタンス作成" do
      let(:relationship) { create(:relationship) }
      let(:test_relationship) { build(:relationship, follower_id: relationship.follower_id, followed_id: relationship.followed_id)}
      it "バリデーションエラーに引っかかっていないか" do
        expect(relationship).to be_valid
      end
      it "フォローフォロワーのデーターが一向でないとエラーが発生する" do
        expect(test_relationship).to be_valid
      end
    end
  end
end
