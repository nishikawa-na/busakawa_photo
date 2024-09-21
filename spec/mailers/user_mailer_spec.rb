require "rails_helper"
require 'base64'

RSpec.describe UserMailer, type: :mailer do
  let(:user) { create(:user)}
  let(:mail) { user.deliver_reset_password_instructions! }
  let(:decoded_text) { mail.body.encoded.split(/\r\n/).map{|i| Base64.decode64(i)}.join }
    it "メール送信ができているか" do
      expect(mail.subject).to eq("ぶさかわフォトよりパスワードリセットのお知らせ")
      expect(mail.to).to eq (["#{user.email}"])
      expect(mail.from).to eq(["busakawa_photo@example.com"])
    end
    it "メール内のURLを確認する" do
      expect(decoded_text).to include(edit_password_reset_url(user.reset_password_token))
    end
end
