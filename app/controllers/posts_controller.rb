class PostsController < ApplicationController
  def index
    # 各料理掲示板一覧アクションを追加して、レンダリングするようにする
    @recipe = params[:recipe]

    # 料理に応じた情報をハッシュで定義
    recipes = {
      "ojakhuri" => { name: "オジャフリ", name2: "ოჯახური",image: "Answer01.png", description: I18n.t("diagnoses.description.ojakhuri2") },
      "badrijani" => { name: "パドリジャーニ", name2: "ბადრიჯანი", image: "Answer02.png", description: I18n.t("diagnoses.description.badrijani2") },
      "sokos" => { name: "ソコスチャシュシュリ", name2: "სოკოს ჭაშუშული", image: "Answer03.png", description: I18n.t("diagnoses.description.sokos_chashushuli2") },
      "pkhali" => { name: "プパリ", name2: "ფხალი", image: "Answer04.png", description: I18n.t("diagnoses.description.pkhali5") },
      "ostri" => { name: "オーストリ", name2: "ოსტრი", image: "Answer05.png", description: I18n.t("diagnoses.description.ostri2") },
      "chikirtma" => { name: "チヒルトゥマ", name2: "ჩიხირთმა", image: "Answer06.png", description: I18n.t("diagnoses.description.chikirtma3") },
      "shkmeruli" => { name: "シュクメルリ", name2: "შქმერული", image: "Answer07.png", description: I18n.t("diagnoses.description.shkmeruli4") },
      "chakhohbili" => { name: "チャホフビリ", name2: "ჩახოხბილი", image: "Answer08.png", description: I18n.t("diagnoses.description.chakhohbili2") }
    }


    @recipe_info = recipes[@recipe]
    # includesメソッド
    # 関連するテーブルをまとめてDBから取得できるメソッド
    # Post.includes(:user) は、Postモデルのレコードと、それに関連するUserモデルのレコードを一度に取得する
    # これにより、最初のクエリでPostレコードを取得し、2つ目のクエリで関連するUserレコードを一度に取得するため、クエリの発行回数を2回に抑えてN+1問題に対応している
    # 該当する料理の投稿をフィルタリングして取得
    @posts = Post.where(recipe: @recipe).includes(:user).page(params[:page]).per(9)
  end

    # newアクションは、新規作成画面を表示するためのアクション
    # Postモデルの新しいインスタンスを@postに代入している
    # この@postは、掲示板作成画面のビュー（app/views/posts/new.html.erb）に渡される
    def new
      @post = Post.new
    end

    def create
      @post = current_user.posts.build(post_params)
      # 投稿を作成する際に、どの料理の掲示板に投稿するかを recipe パラメータとして受け取って保存
      # create アクションにこの処理を追加
      @post.recipe = params[:recipe]  # 料理の種類を保存

      if @post.save
        redirect_to posts_path(recipe: @post.recipe), success: t("defaults.flash_message.created", item: Post.model_name.human)
      else
        flash.now[:danger] = t("defaults.flash_message.not_created", item: Post.model_name.human)
        render :new, status: :unprocessable_entity
      end
    end


    # 掲示板詳細画面を閲覧するためのアクション
    def show
      @post = Post.find(params[:id])
      # Postモデルの新しいインスタンスを@commentに代入している
      # この@commentは、掲示板作成画面のコメント欄（app/views/posts/new.html.erb）に渡される
      @comment = Comment.new
      # includesメソッド
      # 関連するテーブルをまとめてDBから取得できるメソッド
      # Post.includes(:user) は、Postモデルのレコードと、それに関連するUserモデルのレコードを一度に取得する
      # これにより、最初のクエリでPostレコードを取得し、2つ目のクエリで関連するUserレコードを一度に取得するため、クエリの発行回数を2回に抑えてN+1問題に対応している
      @comments = @post.comments.includes(:user).order(created_at: :desc)
    end

    # 掲示板編集画面を閲覧するためのアクション
    def edit
      # 編集画面表示に必要なアクションをコントローラーに定義する
      @post = current_user.posts.find(params[:id])
      # current_user.posts.find(params[:id])と記述することで、ログインしているユーザーが投稿した掲示板一覧の中から、
      # params[:id]の値と同じIDを持ったBoardレコードのみを取得する
      # そのためログインしているユーザーが投稿した掲示板一覧の中に無い掲示板を取得しようとすると、
      # ActiveRecord::RecordNotFoundエラーが発生して、他者が投稿した掲示板の編集画面は表示されない
      # 下記のような表現だと、別ユーザーがその掲示板にアクセスできてしまうので✖

      # Board.find(params[:id])
      # 指定されたIDの掲示板の編集画面を表示することができるが、この場合、すべてのユーザーがその掲示板にアクセスできることになる

      # @board = Board.find(params[:id])
      # .../posts/255/edit のURLにアクセスすると、IDが255の掲示板の編集画面を誰でも表示できてしまう
      # 他のユーザーが作成した掲示板の編集画面にアクセスできてしまうのはサービスとしてもセキュリティ面でも問題
    end


    # 掲示板編集後、更新するためのアクション
    def update
      @post = current_user.posts.find(params[:id])
     # パラメータを更新すると、「掲示板を更新しました」とフラッシュメッセージが出る
     if @post.update(post_params)
      redirect_to post_path(@post), success: t("defaults.flash_message.updated", item: Post.model_name.human)
     else
      # それ以外だと、「掲示板を更新出来ませんでした」とフラッシュメッセージが出る
      flash.now[:danger] = t("defaults.flash_message.not_updated", item: Post.model_name.human)
      render :edit, status: :unprocessable_entity
     end
    end


    # 掲示板を削除するためのアクション
    def destroy
      @post = current_user.posts.find(params[:id])
       # 削除が成功するとtrueを返すが、削除が失敗した場合にはActiveRecord::RecordNotDestroyed例外を発生させる(例外処理)
       # 削除に失敗すると即座に例外を発生させて処理を停止したい場合に有用
       @post.destroy!
        redirect_to posts_path(recipe: @post.recipe), success: t("defaults.flash_message.deleted", item: Post.model_name.human), status: :see_other
    end

    # いいね！した投稿を保存するためのアクション
    # def favorites
    # current_userがいいねしている投稿を取得
    # @favorite_posts = current_user.favorites.includes(:post).map(&:post)
    # end
    def favorites
      # `current_user`がいいねした投稿を取得し、検索条件を適用
      # @favorite_postsの取得方法をransackを用いて行うよう変更
      # favoritesアクションで検索フォームから送信されたparams[:q]を受け取り、current_userがいいねした投稿の中から検索
      @q = Post.joins(:favorites).where(favorites: { user_id: current_user.id }).ransack(params[:q])
      # @q.resultで取得された検索結果を@favorite_postsに代入
      @favorite_posts = @q.result.page(params[:page]).per(9)
    end

    def posts
      # current_userの投稿のransackオブジェクトを作成
      @q = current_user.posts.ransack(params[:q])
      # PostsControllerのpostsアクション内に、ログインユーザーの投稿を取得する処理を追加する
      # 現在のユーザーを取得するためにcurrent_userを使い、関連付けを活用してそのユーザーの投稿のみを取得する
      # 　検索フォームを動かすためのアクション
      # @user_posts = current_user.posts.page(params[:page]).per(9) # 9件ずつページネーション
      # postsアクションでユーザーの投稿を検索条件に応じて取得するようにし、検索フォームをposts.html.erbに表示する
      @user_posts = @q.result.page(params[:page]).per(9)
    end


    private

    def post_params
      params.require(:post).permit(:title, :body, :post_image, :post_image_cache)
    end
  # ストロングパラメーターを使用して、予期しないパラメータのマスアサインメントによるセキュリティリスクを防ぐ
end

# N+1問題
# SQLが必要以上に実行されてしまいパフォーマンスが落ちる問題
# SQLの実行とは、データベースに対してデータの読み書きや検索を行う命令を送信することを意味する
# パフォーマンスが落ちるとは、アプリケーションが要求された操作を完了するまでにかかる時間が増加し、全体的な動作速度が遅くなることを意味する
# includesメソッドを使わず、Post.all で取得した場合、掲示板の投稿者名を表示する部分でN+1問題が発生する
