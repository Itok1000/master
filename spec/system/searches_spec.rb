require 'rails_helper'

RSpec.describe '検索機能', type: :system do
  let(:user) { create(:user) }
let(:post1) { create(:post, user: user, title: 'シュクメルリ', body: 'にんにくと鶏肉を使うのがポイント') }
let(:post2) { create(:post, user: user, title: 'オジャフリ', body: '万人受け') }
let(:post3) { create(:post, user: user, title: 'ワインによく合う', body: '翠燕さんに食べさせたら「これ美味い」って言ってた') }
let(:post4) { create(:post, user: user, title: 'ソコスチャシュシュリは。。。', body: 'しいたけでも美味しくできるのってしいたけたいしさんが言ってたよ') }

  describe '「参考になった」投稿一覧画面での検索' do
    before do
      login(user)
      post1
      post2
      post3
      post4
      user.favorites.create(post: post1)
      user.favorites.create(post: post4)
      visit favorites_posts_path
    end
    context '検索条件に該当する口コミがある場合' do
      describe 'タイトルでの検索機能の検証' do
        it '該当する口コミのみ表示されること' do
          fill_in 'q_title_or_body_cont', with: 'Web'
          click_on '検索'
          Capybara.assert_current_path("/posts/favorites", ignore_query: true)
          expect(current_path).to eq(favorites_posts_path), 'ブックマーク一覧でないページに遷移しています'
          expect(page).to have_content(post1.title), '口コミタイトルでの検索機能が正しく機能していません'
          expect(page).not_to have_content(post2.title), '口コミタイトルでの検索機能が正しく機能していません'
          expect(page).not_to have_content(post3.title), '口コミタイトルでの検索機能が正しく機能していません'
          expect(page).not_to have_content(post4.title), '口コミタイトルでの検索機能が正しく機能していません'
        end
      end

      describe '本文での検索機能の検証' do
        it '該当する口コミのみ表示されること' do
          fill_in 'q_title_or_body_cont', with: '必要'
          click_on '検索'
          Capybara.assert_current_path("/posts/favorites", ignore_query: true)
          expect(current_path).to eq(favorites_posts_path), 'ブックマーク一覧でないページに遷移しています'
          expect(page).to have_content(post4.title), '口コミ本文での検索機能が正しく機能していません'
          expect(page).not_to have_content(post1.title), '口コミ本文での検索機能が正しく機能していません'
          expect(page).not_to have_content(post2.title), '口コミ本文での検索機能が正しく機能していません'
          expect(page).not_to have_content(post3.title), '口コミ本文での検索機能が正しく機能していません'
        end
      end
    end

    context '検索条件に該当する口コミがない場合' do
      it '1件もない旨のメッセージが表示されること' do
        visit favorites_posts_path
        fill_in 'q_title_or_body_cont', with: '一件もヒットしないよ'
        click_on '検索'
        Capybara.assert_current_path("/posts/favorites", ignore_query: true)
        expect(current_path).to eq(favorites_posts_path), 'ブックマーク一覧でないページに遷移しています'
        expect(page).to have_content('「参考になった」投稿はございません'), '1件もヒットしない場合、「参考になった」投稿はございません」というメッセージが表示されること'
      end
    end
  end
end

