class PasswordResetsController < ApplicationController
    # ●skip_before_action について
    # Railsのコントローラーにおいて特定のアクションが実行される前に設定されたフィルターをスキップするために使用される
    # これにより、特定のアクションでフィルターを適用しないように指定できる
    # require_login というフィルターを new および create アクションに対してスキップしている
    # このフィルターは通常、ユーザーがログインしているかどうかを確認するために使用されるが、
    # 新規ユーザー登録のページ（new アクション）やユーザー登録処理（create アクション）では、ユーザーがログインしているかどうかを確認は不要
    # したがって、これらのアクションではログインの確認をスキップしている。このようにして、未ログインのユーザーでもアクセスできるページを作成することが可能
    skip_before_action :require_login
    def new; end

    # パスワードのリセットを要求する
    # ユーザーがパスワードのリセットフォームに電子メールを入力して送信すると、ここに表示される
    def create
      @user = User.find_by(email: params[:email])

      if @user
        @user.deliver_reset_password_instructions!
      else
        Rails.logger.warn "Password reset requested for non-existent email: #{params[:email]}"
      end

      redirect_to login_path, success: t(".success")
    end

    # パスワード再設定フォーム
    def edit
      @token = params[:id]
      @user = User.load_from_reset_password_token(params[:id])

      return if @user.present?

      not_authenticated
      nil
    end

    # このアクションは、ユーザーがパスワード リセット フォームを送信したときに起動
    def update
      @token = params[:id]
      @user = User.load_from_reset_password_token(params[:id])

      if @user.blank?
        not_authenticated
        return
      end

      # パスワード確認の検証を機能させている
      @user.password_confirmation = params[:user][:password_confirmation]
      # 一時トークンをクリアし、パスワードを更新
      if @user.change_password(params[:user][:password])
        redirect_to(login_path, success: t(".success"))
      else
        render action: "edit"
      end
    end
end
