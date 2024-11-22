require "dotenv/load"

access_key = ENV["S3_ACCESS_KEY_ID"]
secret_key = ENV["S3_SECRET_ACCESS_KEY"]
region = ENV["S3_REGION"]
bucket_name = ENV["S3_BUCKET_NAME"]

require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Myapp
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.2

    # Please, add to the `ignore` list any other `lib` subdirectories that do
    # not contain `.rb` files, or that should not be reloaded or eager loaded.
    # Common ones are `templates`, `generators`, or `middleware`, for example.
    config.autoload_lib(ignore: %w[assets tasks])

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
    config.generators.system_tests = nil
    config.generators do |g|
      g.skip_routes true
      g.helper false
      g.test_framework nil
    end

    # Railsのi18nのデフォルト設定を :ja にする
    # config/application.rb に設定を記述
    # config.i18n.default_locale = :ja という記述を追加
    config.i18n.default_locale = :ja
    # Railsアプリケーションのデフォルトの言語設定が日本語（:ja）に設定される
    config.time_zone = "Tokyo"
    # デフォルトのタイムゾーンを日本時間に設定する
  end
end
