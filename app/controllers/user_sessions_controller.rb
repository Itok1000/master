class UserSessionsController < ApplicationController
    skip_before_action :require_login, only: %i[new create]

    def new; end
    # loginメソッドは、gem 'sorcery'が提供しているメソッドの1つ
    # ユーザーの認証を行い、指定されたメールアドレスとパスワードがデータベース内のユーザー情報と一致するかどうかを確認
    # 認証が成功した場合、該当するユーザーはセッションに値をセットされてログイン状態になる
    def create
       @user = login(params[:email], params[:password])
      # loginメソッドは、gem 'sorcery'が提供しているメソッドの1つ
      # ユーザーの認証を行い、指定されたメールアドレスとパスワードがデータベース内のユーザー情報と一致するかどうかを確認
      # 認証が成功した場合、該当するユーザーはセッションに値をセットされてログイン状態になる
      if @user
        # success: t('user_sessions.create.success')を追記し、ログインに成功しましたとフラッシュメッセージを放つ
        redirect_to root_path, success: t("user_sessions.create.success")
      # redirect_toについて
      # redirect_to メソッドは、指定されたURLへユーザーをリダイレクトする
      # リダイレクトはサーバーがクライアントに別のURLへの移動を指示するプロセス
      # このメソッドは通常、アクション完了後にユーザーを適切なページへ導くために使用され、セッション情報の更新や重複データ送信の防止に役立つ
      # 例えば、ログインやログアウト後のリダイレクトはユーザーの認証状態を更新し、その結果を新しいリクエストに即座に反映させる
      else
        # render :new
        # ↓
        # success: t('user_sessions.create.success')を追記し、ログインに失敗しましたとフラッシュメッセージを放つ
        flash.now[:danger] = t("users.create.failure")
        render :new, status: :unprocessable_entity
        # renderについて
        # render メソッドは指定されたビューテンプレートの内容をクライアントに返し、現在のウェブページを更新する
        # この操作は新しいページへの移動を伴わずに行われ、サーバーは直接HTMLをレスポンスとして送信する
        # ユーザーの入力エラーがあった場合に特に有効で、redirect_toが新しいHTTPリクエストを生成しフォームデータを失うのに対し、renderは現在のHTTPリクエスト内でビューを直接表示し、入力データを保持する
      end
    end

    def destroy
      logout
      # ログアウトしましたとフラッシュメッセージを放つ
      redirect_to roots_path, status: :see_other, danger: t("user_sessions.destroy.success")
      # redirect_toについて
      # redirect_to メソッドは、指定されたURLへユーザーをリダイレクトする
      # リダイレクトはサーバーがクライアントに別のURLへの移動を指示するプロセス
      # このメソッドは通常、アクション完了後にユーザーを適切なページへ導くために使用され、セッション情報の更新や重複データ送信の防止に役立つ
      # 例えば、ログインやログアウト後のリダイレクトはユーザーの認証状態を更新し、その結果を新しいリクエストに即座に反映させる

      # status: :see_otherについて
      # HTTPステータスコード303 "See Other"はリダイレクトを指示するコード
      # このステータスはリソースが一時的に別のURIに移動されたことを示し、クライアントにGETメソッドでそのURIを取得するよう指示する
      # Railsのredirect_toメソッドでstatus: :see_otherを指定すると、POSTリクエスト後の新しいページへのGETリクエスト移動が促され、フォームの再送信を防ぎます。
      # status: :see_otherを指定しない場合、リダイレクト後もブラウザがPOSTメソッドを保持し続け、予期せぬ挙動に繋がる恐れがある
    end
end
