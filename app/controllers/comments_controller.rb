class CommentsController < ApplicationController
    def create
      @post = Post.find(params[:post_id])
      @comment = @post.comments.build(comment_params)
      @comment.user = current_user

      if @comment.save
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
