require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe "createアクション" do
    let(:comment) { create(:comment) }
    context "commentsインタンス作成" do
      it "バリデーションエラーが発生しないか" do
        expect(comment).to be_valid
      end
      it " コメントが２文字以下の場合バリデーションエラーが発生する" do
        comment.body = "a"
        expect(comment).to be_invalid
      end
      it "コメントが空の場合バリデーションエラーが発生する" do
        comment.body = ""
        expect(comment).to be_invalid
      end
    end
  end
end
