require 'rails_helper'

RSpec.describe User, type: :model do
  describe "バリデーションチェック" do
    it "バリデーションが機能しているか" do
      user = build(:user)
      expect(user).to be_valid
      expect(user.errors).to be_empty
    end

    it "名前がない場合、エラーになる" do
      no_name = build(:user, user_name: "")
      expect(no_name).to be_invalid
    end

    it "名前が被る場合、エラーになる" do
      create(:user, user_name: "シュクメルリ君")
      other = build(:user, user_name: "シュクメルリ君")
      expect(other).to be_invalid
    end

    it "名前の文字数が長すぎる場合、エラーになる" do
      user = build(:user, user_name: "a" * 256)
      expect(user).to be_invalid
    end
  end
end
