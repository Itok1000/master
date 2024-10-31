source "https://rubygems.org"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 7.2.1"
# The original asset pipeline for Rails [https://github.com/rails/sprockets-rails]
gem "sprockets-rails"
# Use postgresql as the database for Active Record
gem "pg", "~> 1.1"
# Use the Puma web server [https://github.com/puma/puma]
gem "puma", ">= 5.0"
# Bundle and transpile JavaScript [https://github.com/rails/jsbundling-rails]
gem "jsbundling-rails"
# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem "turbo-rails"
# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem "stimulus-rails"
# Bundle and process CSS [https://github.com/rails/cssbundling-rails]
gem "cssbundling-rails"
# Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem "jbuilder"
# Use Redis adapter to run Action Cable in production
# gem "redis", ">= 4.0.1"
# gem 'rails-i18n'を導入
gem "rails-i18n", "~> 7.0.0"

gem "meta-tags"
#### ** 画像を合成する役割のために使用 ** ####
# アップロードされた画像が強制的にそのサイズに引き伸ばされてしまうのを防ぐ
# OGPを使ったXのシェア機能においても万能
gem "mini_magick"
# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

#### ** デバック時に必要 ** ####
# pry-byebugの主な機能は以下のとおり
# - ステップ実行：
# -コードを1行ずつ実行し、プログラムの流れを詳細に追跡できる
# - これにより、エラーの原因を特定しやすくなる

# - ブレークポイント：
# -特定の行でプログラムの実行を停止し、その時点の変数の状態やプログラムの状況を確認できる

# - インタラクティブシェル：
# - その場でコードを試したり、メソッドの定義場所を確認したりすることができる
gem "pry-byebug"
# プログラムのエラーやバグを見つけて修正する時、デバックが必要だが、
# 　そのときに使用されるGemが"pry-byebug"になる

# コードを読み返す、ログを確認する、デバッグツールを使用するなどがある
# デバッグツールを使うと、プログラムの実行を途中で止めて変数の値を確認したり、ステップごとに実行を追跡することができる
# これにより、エラーの原因を効率的に見つけ出すことができる

#### ** ユーザー登録機能時に必要 ** ####
#### **Gemfileに gem 'sorcery', '0.16.3' を記述する**
# Railsプロジェクトで使用するgem（ライブラリ）を管理するファイル
# このファイルにはプロジェクトに必要なすべてのgemが記述される
# bundle install コマンドを実行すると、Gemfileに記載されたgemがインストールされる
# 開発者はプロジェクトの依存関係を一元的に管理し、他の開発者と環境を一致させることができる
# Gemfileでは、gemの名前と必要に応じたバージョン指定を行うことにより、プロジェクトが必要とする正確なgemが提供され、バージョンの衝突や不整合が防げる
gem "sorcery", "0.16.3"
# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"


#### ** 画像アップロード機能時に必要 ** ####
# ファイルアップロードを簡単に行うためのRubyライブラリ
# 画像やビデオなどのファイルをWebアプリケーションにアップロードし、管理する機能を提供する
# これにより、複雑なアップロード処理を簡素化することができる
# ファイルのリサイズやフォーマット変換、バリデーションなどの機能も提供しており、
# ユーザーがアップロードしたファイルの安全性と品質を確保するのに役立つ
gem "carrierwave", "2.2.2"



#### ** ユーザーに表示するデータを整形・加工する時に必要 ** ####
# # **Draper（ドレッパー）**
# Draperとは、Ruby on Railsで使うgemの一つ
# Draperをインストールすると、デコレーターを作成できるようになり、ユーザーに表示するデータを整形・加工するための処理（ビューに関するロジック）をモデルから分離し、コードの保守性と読みやすさを向上させることができる
gem "draper", "4.0.2"

#### ** 高度な検索機能を作る時に必要 ** ####
# # **ransack**
# Ruby on Rails アプリケーションに高度な検索機能を簡単に追加するための gemの一つ
# ransackは、検索フォームの作成から検索クエリの生成、検索結果の表示までを包括的にサポートする
# ransackの主な機能は次のとおり
# 検索フォームの生成 ： ransackは、簡単に検索フォームを生成するためのヘルパーメソッドを提供する
# 柔軟な検索条件 ： 部分一致検索、完全一致検索、範囲検索など、さまざまな検索条件をサポートする
# ソート機能 ： 検索結果を特定のカラムでソートする機能も提供する
# シンプルな構文 ： ransackはシンプルなRuby構文を使用しているため、既存のコードに容易に統合できる
gem "ransack"
# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[ windows jruby ]

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"

# RatyはjQueryに依存しているから、まずはjQueryをプロジェクトに追加しておく必要がある
gem "jquery-rails"

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[ mri windows ], require: "debug/prelude"

  # Static analysis for security vulnerabilities [https://brakemanscanner.org/]
  gem "brakeman", require: false

  # Omakase Ruby styling [https://github.com/rails/rubocop-rails-omakase/]
  gem "rubocop-rails-omakase", require: false
end

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem "web-console"
end

group :test do
  # Use system testing [https://guides.rubyonrails.org/testing.html#system-testing]
  gem "capybara"
  gem "selenium-webdriver"
end
