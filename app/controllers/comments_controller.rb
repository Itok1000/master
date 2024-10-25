class CommentsController < ApplicationController
    def create
      # findメソッド
      # RailsのActiveRecordが提供するメソッドで、渡されたIDを元にデータベースから特定のレコードを取得する
      # 例えば、User.find(255)とすると、IDが255のUsersテーブルのレコードを取得する。
      # 存在しないIDを渡すと、ActiveRecord::RecordNotFound例外が発生する
      @post = Post.find(params[:post_id])
      # createアクション内で params[:post_id] を使うことでURLの掲示板のIDパラメータ(65535)を取得できる
      # params はハッシュ形式でデータを保持するため、キーを指定して対応する値を取得することができる
      @comment = @post.comments.build(comment_params)
      @comment.user = current_user

      if @comment.save
        # url オプションを用いることで、フォームの送信先URLを明示的に指定
        redirect_to post_path(@post), success: t("defaults.flash_message.created", item: Comment.model_name.human)
      else
        @comments = @post.comments.includes(:user).order(created_at: :desc)
        flash.now[:danger] = t("defaults.flash_message.not_created", item: Comment.model_name.human)
        render "posts/show", status: :unprocessable_entity
      end
    end

    private

    def comment_params
      params.require(:comment).permit(:body).merge(post_id: params[:post_id])
    end
end
