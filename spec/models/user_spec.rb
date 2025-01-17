require 'rails_helper'

RSpec.describe User, type: :model do
  describe "バリデーションチェック" do
    it "バリデーションが機能しているか" do
      user = build(:user)
      expect(user).to be_valid
      expect(user.errors).to be_empty
    end

    it "ユーザーネームが入力されていること" do
      no_name = build(:user, user_name: "")
      expect(no_name).to be_invalid
    end

    it "名前の文字数が長すぎないこと" do
      user = build(:user, user_name: "a" * 256)
      expect(user).to be_invalid
    end

    it "メールアドレスが入力されていること" do
      no_email = build(:user, email: "")
      expect(no_email).to be_invalid
    end

    it "パスワードが3文字以下でないこと" do
      user = build(:user, password: "a" * 3)
      expect(user).to be_invalid
    end

    it "パスワード入力されていること" do
      no_password = build(:user, password: "")
      expect(no_password).to be_invalid
    end

    it "確認用パスワードが入力されていること" do
      no_password_confirmation = build(:user, password_confirmation: "")
      expect(no_password_confirmation).to be_invalid
    end

    it "パスワードと確認用パスが一致すること" do
      user = build(:user, password: "gamarjoba", password_confirmation: "gamarjoba")
      expect(user).to be_valid
    end
  end
end
