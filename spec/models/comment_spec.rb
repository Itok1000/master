require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe "コメント投稿モデルのバリデーションチェック" do
    it "コメントが記載されていること" do
      no_body = build(:comment, body: "")
      expect(no_body).to be_invalid
    end

    it "コメントが長すぎないこと(65,535字以内)" do
      body = build(:comment, body: "a" * 65_535)
      expect(body).to be_invalid
    end
  end
end
