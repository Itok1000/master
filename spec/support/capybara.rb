# spec/support/capybara.rbファイル
# capybaraの設定を書いていく

RSpec.configure do |config|
    config.before(:each, type: :system) do
      driven_by :remote_chrome
      Capybara.server_host = IPSocket.getaddress(Socket.gethostname)
      Capybara.server_port = 4444
      Capybara.app_host = "http://#{Capybara.server_host}:#{Capybara.server_port}"
    end

    config.before(:each, type: :system, js: true) do
      driven_by :remote_chrome
      Capybara.server_host = IPSocket.getaddress(Socket.gethostname)
      Capybara.server_port = 4444
      Capybara.app_host = "http://#{Capybara.server_host}:#{Capybara.server_port}"
    end
  end

  require 'capybara/rspec'
  require 'selenium-webdriver'
  # capybaraの設定を書いていく
  Capybara.register_driver :remote_chrome do |app|
    options = Selenium::WebDriver::Chrome::Options.new
    options.add_argument('no-sandbox')
    options.add_argument('headless')
    options.add_argument('disable-gpu')
    options.add_argument('window-size=1680,1050')
    Capybara::Selenium::Driver.new(app, browser: :remote, url: ENV['SELENIUM_DRIVER_URL'], capabilities: options)
  end
