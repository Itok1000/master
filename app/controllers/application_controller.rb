class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  # before_action は、アクションが実行される前に指定されたメソッドを呼び出す
  # application_controller.rb に記述することで、ApplicationController クラスを継承しているすべてのコントローラで
  # before_action が適用される
  before_action :require_login
  # require_login は、gem 'sorcery' が提供するメソッドの一つで、ユーザーがログインしているかどうかを判定
  # ログインしていない場合は、not_authenticated メソッドで指定されたパスにリダイレクト
  private

  # not_authenticated メソッドも gem 'sorcery' が提供するもので、ログインしていない場合に指定されたパスにリダイレクト
  def not_authenticated
    redirect_to login_path
    # application_controller.rb でこのメソッドをオーバーライドすることで、
    # デフォルトのリダイレクト先を root_path から login_path に変更
  end
end
