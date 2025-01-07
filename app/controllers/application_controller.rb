class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  # before_action は、アクションが実行される前に指定されたメソッドを呼び出す
  # application_controller.rb に記述することで、ApplicationController クラスを継承しているすべてのコントローラで
  # before_action が適用される
  before_action :require_login
  # require_login は、gem 'sorcery' が提供するメソッドの一つで、ユーザーがログインしているかどうかを判定
  # ログインしていない場合は、not_authenticated メソッドで指定されたパスにリダイレクト

  # before_action は、アクションが実行される前に指定されたメソッドを呼び出す
  # application_controller.rb に記述することで、ApplicationController クラスを継承しているすべてのコントローラで
  # before_action が適用される
  before_action :set_locale
  # set_localeは各リクエストの冒頭にロケールを設定して、リクエストが持続する間はすべての文字列が指定のロケールで翻訳されるようにする
  # ロケールはApplicationControllerのbefore_actionで設定できる

  add_flash_types :success, :danger
  # フラッシュメッセージのタイプを追加するメソッド
  # デフォルトでは、notice と alert の二種類のキーしか用意されていないので、
  # 今回は、成功・失敗した際のメッセージに適用されるキーを追加するために、success と danger という2つのキーを追加

  def default_url_options
    { locale: I18n.locale }
  end
  # 上のようにすることで、url_forに依存するすべてのヘルパーメソッド (root_pathやroot_urlなどの名前付きメソッドや
  # books_pathやbooks_urlなどのリソースルーティングを持つヘルパー) では自動的にロケール情報がクエリ文字列に含まれるようになる
  # たとえばhttp://localhost:3001/?locale=jaのような形式になる

  private

  # not_authenticated メソッドも gem 'sorcery' が提供するもので、ログインしていない場合に指定されたパスにリダイレクト
  def not_authenticated
    redirect_to login_path, danger: t("defaults.flash_message.require_login")
    # application_controller.rb でこのメソッドをオーバーライドすることで、
    # デフォルトのリダイレクト先を root_path から login_path に変更
    # defaults.flash_message.require_login = 未ログイン時にログインページにリダイレクトさせた際に表示されるフラッシューメッセージを設定
  end

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end
  # リクエスト間でロケールを管理する
  # I18n.localeを明示的に設定しない限り、すべての訳文でデフォルトのロケールが使われる
  # ローカライズされたアプリケーションは、将来複数ロケールのサポートが必要
  # これを行うためには、各リクエストの冒頭にロケールを設定して、
  # リクエストが持続する間はすべての文字列が指定のロケールで翻訳されるようにしておくべき
  # ロケールはApplicationControllerのbefore_actionで設定できる
end
