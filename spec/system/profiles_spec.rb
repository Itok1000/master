require 'rails_helper'

RSpec.describe "Profiles", type: :system do
  let(:user) { create(:user) }

  describe "ログイン後" do
    let!(:user) { create(:user, email: "test@test.com", password: "123456789", password_confirmation: "123456789") }
    before do
      visit '/login'
      fill_in "email", with: "test@test.com"
      fill_in "password", with: "123456789"
      click_button "ログイン"
    end

    it "プロフィールの詳細が見られること" do
        find('#navbarDropdown').click
        expect(page).to have_content('プロフィール設定'), 'ヘッダーに「プロフィール設定」というテキストが表示されていること'
        click_on 'プロフィール設定'
        expect(page).to have_content(user.decorate.full_name), 'プロフィールページにユーザー名が表示されていること'
        expect(page).to have_content(user.email), 'プロフィールページにメールアドレスが表示されていること'
    end

    it "プロフィールの編集ができること(メールアドレス)" do
      find('#navbarDropdown').click
      click_on 'プロフィール設定'
      click_on '編集'
      expect(page).to have_content('プロフィール編集'), 'プロフィール編集ページに「プロフィール編集」というテキストが表示されていること'
      fill_in "メールアドレス", with: "new_email@test.com"
      click_button "更新"
      expect(page).to have_content('ユーザーを更新しました'), 'プロフィール更新後に成功メッセージが表示されること'
    end

    it "プロフィールの編集ができること(ユーザーネーム)" do
      find('#navbarDropdown').click
      click_on 'プロフィール設定'
      click_on '編集'
      expect(page).to have_content('プロフィール編集'), 'プロフィール編集ページに「プロフィール編集」というテキストが表示されていること'
      fill_in "ユーザーネーム", with: "新しいユーザー名"
      click_button "更新"
      expect(page).to have_content('ユーザーを更新しました'), 'プロフィール更新後に成功メッセージが表示されること'
    end
  end
end
