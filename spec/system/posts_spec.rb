require 'rails_helper'

RSpec.describe "Posts", type: :system do
  let(:user) { create(:user) }
  let(:post) { create(:post, user: user) }

  describe "ログイン前" do
    it "口コミ一覧が見れないこと" do
      visit "/posts?recipe=ojakhuri"
      Capybara.assert_current_path("/login", ignore_query: true)
      expect(current_path).to eq('/login')
      expect(page).to have_content 'ログインしてください'
    end

    it "口コミ詳細が見れないこと" do
      visit "/posts/2"
      Capybara.assert_current_path("/login", ignore_query: true)
      expect(current_path).to eq('/login')
      expect(page).to have_content 'ログインしてください'
    end

    it "口コミ編集できないこと" do
      visit "posts/2/edit"
      Capybara.assert_current_path("/login", ignore_query: true)
      expect(current_path).to eq('/login')
      expect(page).to have_content 'ログインしてください'
    end

    it "「参考になった」投稿が見れないこと" do
      visit "/posts/favorites"
      Capybara.assert_current_path("/login", ignore_query: true)
      expect(current_path).to eq('/login')
      expect(page).to have_content 'ログインしてください'
    end

    it "「投稿一覧」が見れないこと" do
      visit "/posts/posts"
      Capybara.assert_current_path("/login", ignore_query: true)
      expect(current_path).to eq('/login')
      expect(page).to have_content 'ログインしてください'
    end
  end
end
