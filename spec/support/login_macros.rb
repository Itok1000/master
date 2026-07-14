module LoginMacros
  def login(user)
    visit login_path
    click_link 'ログイン'
    fill_in 'メールアドレス', with: user.email
    fill_in 'パスワード', with: 'password'
    click_button 'ログイン'
  end
end

RSpec.configure do |config|
  config.include LoginMacros, type: :system
end
