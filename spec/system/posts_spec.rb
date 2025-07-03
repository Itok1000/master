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

    it "口コミ投稿ができないこと" do
      visit "/posts/new"
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

    it "口コミのタイトルが編集できないこと" do
      visit "posts/2/edit"
      Capybara.assert_current_path("/login", ignore_query: true)
      expect(current_path).to eq('/login')
      expect(page).to have_content 'ログインしてください'
    end

    it "口コミの本文が編集できないこと" do
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

  describe "ログイン後" do
    let!(:user) { create(:user, email: "test@test.com", password: "123456789", password_confirmation: "123456789") }
    before do
      visit '/login'
      fill_in "email", with: "test@test.com"
      fill_in "password", with: "123456789"
      click_button "ログイン"
    end

    it "口コミ投稿ができること" do
      visit "/posts/new/?recipe=ojakhuri"
      fill_in "post[title]", with: "新しい口コミ"
      fill_in "post[body]", with: "口コミの本文"
      click_button "登録"
      expect(page).to have_content '料理の評価を作成しました'
    end

    it "(タイトル未入力の場合)口コミ投稿が失敗すること" do
      visit "/posts/new/?recipe=ojakhuri"
      fill_in "post[title]", with: ""
      fill_in "post[body]", with: "口コミの本文(本文は必須)"
      click_button "登録"
      expect(current_path).to eq("/posts/new/")
      expect(page).to have_content "タイトルを入力してください"
    end

    it "(タイトル未入力の場合)口コミ投稿が失敗すること" do
      visit "/posts/new/?recipe=ojakhuri"
      fill_in "post[title]", with: "口コミのタイトル(タイトルは必須)"
      fill_in "post[body]", with: ""
      click_button "登録"
      expect(current_path).to eq("/posts/new/")
      expect(page).to have_content "本文を入力してください"
    end

    it '正しいタイトルが表示されていること(評価の詳細とみんなの反応)' do
     visit "/posts/#{post.id}"
     expect(page).to have_title("#{post.title} | ガマルジョバ/გამარჯობა"), '口コミ詳細のタイトルに「参考になった」投稿が含まれていること'
    end

    it "口コミ詳細が見れること" do
      visit "/posts/#{post.id}"
      expect(current_path).to eq("/posts/#{post.id}")
      expect(page).to have_content post.title
    end

    it "口コミのタイトルが編集ができること" do
      visit "/posts/#{post.id}/edit"
      expect(current_path).to eq("/posts/#{post.id}/edit")
      fill_in "post[title]", with: "新しいタイトル"
      click_button "更新"
      expect(page).to have_content '料理の評価を更新しました'
    end

    it "口コミの本文が編集ができること" do
      visit "/posts/#{post.id}/edit"
      expect(current_path).to eq("/posts/#{post.id}/edit")
      fill_in "post[body]", with: "新しい本文"
      click_button "更新"
      expect(page).to have_content '料理の評価を更新しました'
    end

    let!(:post) { create(:post, user: user, title: "テストタイトル", body: "テスト本文", star: 3) }

    it '正しいタイトルが表示されていること(投稿一覧)' do
     visit "/posts/posts"
     expect(page).to have_title("投稿一覧 | ガマルジョバ/გამარჯობა"), '投稿一覧ページのタイトルに「投稿一覧」が含まれていること'
    end

    it "「投稿一覧」が見れること" do
      visit "/posts/posts"
      expect(current_path).to eq('/posts/posts')
      expect(page).to have_content '投稿一覧'
    end

    it '正しいタイトルが表示されていること(「参考になった」投稿)' do
     visit "/posts/favorites"
     expect(page).to have_title("「参考になった」投稿 | ガマルジョバ/გამარჯობა"), '「参考になった」投稿を保存するページのタイトルに「参考になった」投稿が含まれていること'
    end

    it "「参考になった」投稿が見れること" do
      visit "/posts/favorites"
      expect(current_path).to eq('/posts/favorites')
      expect(page).to have_content '「参考になった」投稿'
    end

    context '20件以下の場合' do
      let!(:posts) { create_list(:post, 9, user: user, star: 3) }
      it 'ページングが表示されないこと' do
        visit "/posts?recipe=ojakhuri"
        expect(page).not_to have_selector('.pagination')
      end
    end
  end
end
