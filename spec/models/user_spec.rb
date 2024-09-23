require 'rails_helper'

RSpec.describe User, type: :model do
  describe "createアクション" do
    let(:user) { create(:user) }
    let(:another_user) { build(:user) }
    context 'usersインスタンス作成' do
      it 'バリデーションエラーに引っかかっていないか' do
        expect(user).to be_valid
      end
    end

    it 'DB上にハッシュ化されたパスワードが存在していること' do
      crypted_password = user.crypted_password
      expect(crypted_password).not_to be_empty
    end

    it 'ユーザーの名前が空の場合、エラーが発生すること' do
      user.name = nil
      expect(user).to be_invalid
    end

    it 'ユーザーのメールアドレスが空の場合、エラーが発生すること' do
      user.email = nil
      expect(user).to be_invalid
    end
    it 'ユーザーのメールアドレスが重複しているとエラーが発生すること' do
      another_user.email = user.email
      expect(another_user).to be_invalid
    end
    it 'ユーザーのパスワードが３文字以下であるとエラーが発生すること' do
      user.password = "a"
      expect(user).to be_invalid
    end
    it 'パスワードの値が空の場合、エラーが発生すること' do
      another_user.password = ""
      expect(another_user).to be_invalid
    end
    it 'パスワード確認の値が空の場合、エラーが発生すること' do
      another_user.password_confirmation = ""
      expect(another_user).to be_invalid
    end
    it 'パスワードトクーンが重複している場合、エラーが発生すること' do
      another_user.reset_password_token = user.reset_password_token
      expect(another_user).to be_invalid
    end
  end
end
