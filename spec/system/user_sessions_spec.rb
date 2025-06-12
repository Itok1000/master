require 'rails_helper'
RSpec.describe "UserSessions", type: :system do
  let(:user) { create(:user) }
  describe "ログイン前" do
    context "ログイン" do
      it "メールアドレスが未記載でログインできないこと" do
        visit '/login'
        fill_in "email", with: ""
        fill_in "password", with: "123456789"
        click_button "ログイン"
        Capybara.assert_current_path("/login", ignore_query: true)
        expect(page).to have_content 'ユーザー登録に失敗しました'
      end

      it "パスワードが未記載でログインできないこと" do
        visit '/login'
        fill_in "email", with: "test@test.com"
        fill_in "password", with: ""
        click_button "ログイン"
        Capybara.assert_current_path("/login", ignore_query: true)
        expect(page).to have_content 'ユーザー登録に失敗しました'
      end

      it "メールアドレスが間違っているとでログインできないこと" do
        visit '/login'
        fill_in "email", with: "ttest@test.com"
        fill_in "password", with: "123456789"
        click_button "ログイン"
        Capybara.assert_current_path("/login", ignore_query: true)
        expect(page).to have_content 'ユーザー登録に失敗しました'
      end

      it "パスワードが間違っているとでログインできないこと" do
        visit '/login'
        fill_in "email", with: "test@test.com"
        fill_in "password", with: "13456789"
        click_button "ログイン"
        Capybara.assert_current_path("/login", ignore_query: true)
        expect(page).to have_content 'ユーザー登録に失敗しました'
      end

      it '「初めての方はこちら」のリンクがあること' do
        visit "/login"
        expect(page).to have_content '初めての方はこちら'
      end

      it '「初めての方はこちら」のリンクを押下するとユーザー新規登録ページに遷移すること' do
        visit "/login"
        click_link "初めての方はこちら"
        Capybara.assert_current_path("/users/new", ignore_query: true)
      end

      it 'Googleログインするためのリンクがあること' do
        visit "/login"
        expect(page).to have_content 'Googleログインの方はこちら'
      end

      it 'Googleログインのリンクを押下するとGoogle認証ページに遷移すること' do
        visit "/login"
        visit "/auth/google_oauth2"
        Capybara.assert_current_path("/auth/google_oauth2", ignore_query: true)
      end
    end
  end
  describe "ログイン" do
    let!(:user) { create(:user, email: "test@test.com", password: "123456789", password_confirmation: "123456789") }
    context '認証情報が正しい場合' do
        it 'ログインできること' do
          visit '/login'
          fill_in 'メールアドレス', with: "test@test.com"
          fill_in 'パスワード', with: "123456789"
          click_button 'ログイン'
          Capybara.assert_current_path("/", ignore_query: true)
          expect(current_path).to eq root_path
          expect(page).to have_content('ログインしました'), 'フラッシュメッセージ「ログインしました」が表示されていること'
        end
    end
  end
end
