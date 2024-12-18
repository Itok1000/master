require 'rails_helper'

RSpec.describe "Posts", type: :system do
  let(:user) { create(:user) }
  let(:post) { create(:post, user: user) }

  describe "ログイン前" do
    it "口コミ一覧が見れないこと" do
      visit "posts?recipe=ojakhuri"
      expect(page).to have_content'ログインしてください'
    end
  end

  describe "ログイン後" do
    # context '口コミがある場合' do
      
    # end
  end
end
