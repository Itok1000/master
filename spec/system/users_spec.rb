require 'rails_helper'
RSpec.describe "Users", type: :system do
  
  describe "ログイン前" do

    context '入力情報異常系' do
      it 'ユーザーが新規作成できないこと' do
        visit '/users/new'
        expect {
          fill_in "user[email]", with: 'example@example.com'
          click_button "登録する"
        }.to change { User.count }.by(0)
      end
    end

    context "ユーザー登録" do
      it "フォームの入力値が正常の場合登録できること" do
        visit "users/new"
        expect{
          fill_in "user[user_name]", with: "テスト太郎"
          fill_in "user[email]", with: "test@test.com"
          fill_in "user[password]", with: "123456789"
          fill_in "user[password_confirmation]", with: "123456789"
          click_button "登録する"
          Capybara.assert_current_path("/login", ignore_query: true)
        }.to change { User.count }.by(1)
      end

      it "名前が記載されていること" do
        visit "users/new"
          fill_in "user[user_name]", with: ""
          fill_in "user[email]", with: "test@test.com"
          fill_in "user[password]", with: "123456789"
          fill_in "user[password_confirmation]", with: "123456789"
          click_button "登録する"
          expect(page).to have_content 'ユーザー登録に失敗しました'
          expect(page).to have_content "ユーザーネームを入力してください"
      end

      it "メールアドレスが記載されていること" do
        visit "users/new"
          fill_in "user[user_name]", with: "テスト太郎"
          fill_in "user[email]", with: ""
          fill_in "user[password]", with: "123456789"
          fill_in "user[password_confirmation]", with: "123456789"
          click_button "登録する"
          expect(page).to have_content 'ユーザー登録に失敗しました'
          expect(page).to have_content "メールアドレスを入力してください"
      end

      it "パスワードとパスワードの確認が一致していること" do
        visit "users/new"
          fill_in "user[user_name]", with: "テスト太郎"
          fill_in "user[email]", with: "test@test.com"
          fill_in "user[password]", with: "123456789"
          fill_in "user[password_confirmation]", with: "987654321"
          click_button "登録する"
          expect(page).to have_content 'ユーザー登録に失敗しました'
          expect(page).to have_content "パスワード確認とパスワードの入力が一致しません"
      end

      it "パスワードが3文字以上であること" do
        visit "users/new"
          fill_in "user[user_name]", with: "テスト太郎"
          fill_in "user[email]", with: "test@test.com"
          fill_in "user[password]", with: "1"
          fill_in "user[password_confirmation]", with: "1"
          click_button "登録する"
          expect(page).to have_content 'ユーザー登録に失敗しました'
          expect(page).to have_content "パスワードは3文字以上で入力してください"
      end

      it "パスワード確認が記載されていること" do
        visit "users/new"
          fill_in "user[user_name]", with: "テスト太郎"
          fill_in "user[email]", with: "test@test.com"
          fill_in "user[password]", with: "1"
          fill_in "user[password_confirmation]", with: ""
          click_button "登録する"
          expect(page).to have_content 'ユーザー登録に失敗しました'
          expect(page).to have_content"パスワード確認を入力してください"
      end

      it '登録済みのメールアドレスの場合、新規で登録できないこと' do
        existed_user = create(:user)
        visit '/users/new'
        fill_in "user[user_name]", with: "テスト太郎"
        fill_in "user[email]", with: existed_user.email
        fill_in "user[password]", with: 'password'
        fill_in "user[password_confirmation]", with: 'password'
        click_button "登録する"
        expect(page).to have_content 'ユーザー登録に失敗しました'
        expect(page).to have_content 'メールアドレスはすでに存在します'
      end

      it '登録済みの名前の場合、新規で登録できないこと' do
        existed_user = create(:user)
        visit '/users/new'
        fill_in "user[user_name]", with: "シュクメルリ君"
        fill_in "user[email]", with: "test@test.com"
        fill_in "user[password]", with: 'password'
        fill_in "user[password_confirmation]", with: 'password'
        click_button "登録する"
        expect(page).to have_content 'ユーザー登録に失敗しました'
        expect(page).to have_content 'ユーザーネームはすでに存在します'
      end
    end
  end
end
