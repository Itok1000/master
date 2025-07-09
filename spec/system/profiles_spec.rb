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
  end
end
