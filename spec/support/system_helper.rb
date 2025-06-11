module SystemHelper
  def login_as_general
   general_user = create(:user, email: 'example@gmail.com', password: '12345678', password_confirmation: '12345678')
   visit root_path
   click_link "ログイン"
   fill_in 'email', with: 'example@gmail.com'
   fill_in 'password', with: '12345678'
   click_button 'ログイン'
  end
end

RSpec.configure do |config|
  config.include SystemHelper
end
