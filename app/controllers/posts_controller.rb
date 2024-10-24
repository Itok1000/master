class PostsController < ApplicationController
    def index
        # 各料理掲示板一覧アクションを追加して、レンダリングするようにする
        @recipe = params[:recipe]

        # 料理に応じた情報をハッシュで定義
        recipes = {
          "ojakhuri" => { name: "オジャフリ", image: "Answer01.png", description: I18n.t("diagnoses.description.ojakhuri2") },
          "badrijani" => { name: "パドリジャーニ", image: "Answer02.png", description: I18n.t("diagnoses.description.badrijani2") },
          "sokos" => { name: "ソコスチャシュシュリ", image: "Answer03.png", description: I18n.t("diagnoses.description.sokos_chashushuli2") },
          "pkhali" => { name: "プパリ", image: "Answer04.png", description: I18n.t("diagnoses.description.pkhali5") },
          "ostri" => { name: "オーストリ", image: "Answer05.png", description: I18n.t("diagnoses.description.ostri2") },
          "chikirtma" => { name: "チヒルトゥマ", image: "Answer06.png", description: I18n.t("diagnoses.description.chikirtma3") },
          "shkmeruli" => { name: "シュクメルリ", image: "Answer07.png", description: I18n.t("diagnoses.description.shkmeruli4") },
          "chakhohbili" => { name: "チャホフビリ", image: "Answer08.png", description: I18n.t("diagnoses.description.chakhohbili2") }
        }


        @recipe_info = recipes[@recipe]
        # includesメソッド
        # 関連するテーブルをまとめてDBから取得できるメソッド
        # Post.includes(:user) は、Boardモデルのレコードと、それに関連するUserモデルのレコードを一度に取得する
        # これにより、最初のクエリでBoardレコードを取得し、2つ目のクエリで関連するUserレコードを一度に取得するため、クエリの発行回数を2回に抑えてN+1問題に対応している
        # 該当する料理の投稿をフィルタリングして取得
        @posts = Post.where(recipe: @recipe).includes(:user)
    end
    # newアクションは、新規作成画面を表示するためのアクション
    # Boardモデルの新しいインスタンスを@postに代入している
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
# includesメソッドを使わず、Board.all で取得した場合、掲示板の投稿者名を表示する部分でN+1問題が発生する
