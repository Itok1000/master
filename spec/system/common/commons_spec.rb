require 'rails_helper'

RSpec.describe '共通系', type: :system do
  context 'ログイン前' do
    before do
      visit root_path
    end
    describe 'ヘッダー' do
      it 'ヘッダーが正しく表示されていること' do
        expect(page).to have_content('ログイン'), 'ヘッダーに「ログイン」というテキストが表示されていること'
        expect(page).to have_content('新規登録'), 'ヘッダーに「新規登録」というテキストが表示されていること'
      end
    end

    describe 'フッター' do
      it 'フッターが正しく表示されていること' do
        expect(page).to have_content('© 2024. Itok1000'), '「© 2024. Itok1000」というテキストが表示されていること'
        expect(page).to have_content('利用規約'), '「利用規約」というテキストが表示されていること'
        expect(page).to have_content('プライバシーポリシー'), '「プライバシーポリシー」というテキストが表示されていること'
        expect(page).to have_content('お問い合わせ'), '「お問い合わせ」というテキストが表示されていること'
      end
    end
  end

  context 'ログイン後' do
    before do
      login_as_general
    end
    describe 'ヘッダー' do
      it 'ヘッダーが正しく表示されていること' do
        expect(page).to have_content('ログアウト'), 'ヘッダーに「ログアウト」というテキストが表示されていません'
      end
    end
  end
end
