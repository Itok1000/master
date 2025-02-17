class Admin::PostsController < Admin::BaseController
    before_action :set_post, only: %i[show edit update destroy]
  
    def index
      @q = Post.ransack(params[:q])
      @posts = @q.result(distinct: true).page(params[:page]).per(10)
    end
  
    def show; end
  
    def edit; end
  
    def update
      @q = Post.ransack(params[:q])
      if @post.update(post_params)
        redirect_to admin_post_path(@post), success: t('defaults.flash_message.updated', item: Post.model_name.human), status: :see_other
      else
        flash.now[:danger] = t('defaults.flash_message.not_updated', item: Post.model_name.human)
      end
    end
  
    def destroy
      @post.destroy!
      redirect_to admin_posts_path, success: t('defaults.flash_message.deleted', item: Post.model_name.human), status: :see_other
    end
  
    private
  
    def set_post
      @post = Post.find(params[:id])
    end
  
    def post_params
      params.require(:post).permit(:title, :body, :post_image, :post_image_cache)
    end
end