require 'rails_helper'

RSpec.describe Post, type: :model do
  describe "口コミ投稿モデルのバリデーションチェック" do
    it "タイトルが記載されていること" do
      no_title = build(:post, title: "")
      expect(no_title).to be_invalid
    end

    it "タイトルが長すぎないこと(255字以内)" do
      title = build(:post, title: "a" * 255)
      expect(title).to be_invalid
    end

    it "本文が記載されていること" do
      no_body = build(:post, body: "")
      expect(no_body).to be_invalid
    end

    it "本文が長すぎないこと(65,535字以内)" do
      body = build(:post, body: "a" * 65_535)
      expect(body).to be_invalid
    end
  end
end
