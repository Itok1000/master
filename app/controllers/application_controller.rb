class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  # before_action は、アクションが実行される前に指定されたメソッドを呼び出す
  # application_controller.rb に記述することで、ApplicationController クラスを継承しているすべてのコントローラで
  # before_action が適用される
  before_action :require_login
  # require_login は、gem 'sorcery' が提供するメソッドの一つで、ユーザーがログインしているかどうかを判定
  # ログインしていない場合は、not_authenticated メソッドで指定されたパスにリダイレクト
  add_flash_types :success, :danger
  # フラッシュメッセージのタイプを追加するメソッド
  # デフォルトでは、notice と alert の二種類のキーしか用意されていないので、
  # 今回は、成功・失敗した際のメッセージに適用されるキーを追加するために、success と danger という2つのキーを追加
  private

  # not_authenticated メソッドも gem 'sorcery' が提供するもので、ログインしていない場合に指定されたパスにリダイレクト
  def not_authenticated
    redirect_to login_path, danger: t("defaults.flash_message.require_login")
    # application_controller.rb でこのメソッドをオーバーライドすることで、
    # デフォルトのリダイレクト先を root_path から login_path に変更
    # defaults.flash_message.require_login = 未ログイン時にログインページにリダイレクトさせた際に表示されるフラッシューメッセージを設定
  end
end
