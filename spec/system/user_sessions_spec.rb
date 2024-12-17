require 'rails_helper'
RSpec.describe "UserSessions", type: :system do
  describe "ログイン前" do
    context "ログイン後" do
      before do
        visit "/login"
      end
      it "フォームの入力値が正常の場合、ログインできること" do
          fill_in "email", with: "test@test.com"
          fill_in "password", with: "123456789"
          click_button "ログイン"
          Capybara.assert_current_path("/login", ignore_query: true)
          
      end

      it "メールアドレスが未記載でログインできないこと" do
        fill_in "email", with: ""
        fill_in "password", with: "123456789"
        click_button "ログイン"
        expect(page).to have_content 'ユーザー登録に失敗しました'
      end

      it "パスワードが未記載でログインできないこと" do
        fill_in "email", with: "test@test.com"
        fill_in "password", with: ""
        click_button "ログイン"
        expect(page).to have_content 'ユーザー登録に失敗しました'
      end
    end
  end
end
