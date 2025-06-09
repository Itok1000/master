class PostsController < ApplicationController
  def index
    @recipe = params[:recipe]

    recipes = {
      "ojakhuri" => { name: I18n.t("diagnoses.description.ojakhuri"), name2: "ოჯახური", image: "Answer01.webp", description: I18n.t("diagnoses.description.ojakhuri3") },
      "badrijani" => { name: I18n.t("diagnoses.description.badrijani"), name2: "ბადრიჯანი", image: "Answer02.webp", description: I18n.t("diagnoses.description.badrijani2") },
      "sokos" => { name: I18n.t("diagnoses.description.sokos_chashushuli"), name2: "სოკოს ჭაშუშული", image: "Answer03.webp", description: I18n.t("diagnoses.description.sokos_chashushuli2") },
      "pkhali" => { name: I18n.t("diagnoses.description.pkhali"), name2: "ფხალი", image: "Answer04.webp", description: I18n.t("diagnoses.description.pkhali5") },
      "ostri" => { name: I18n.t("diagnoses.description.ostri"), name2: "ოსტრი", image: "Answer05.webp", description: I18n.t("diagnoses.description.ostri2") },
      "chikirtma" => { name: I18n.t("diagnoses.description.chikirtma"), name2: "ჩიხირთმა", image: "Answer06.webp", description: I18n.t("diagnoses.description.chikirtma3") },
      "shkmeruli" => { name: I18n.t("diagnoses.description.shkmeruli"), name2: "შქმერული", image: "Answer07.webp", description: I18n.t("diagnoses.description.shkmeruli4") },
      "chakhohbili" => { name: I18n.t("diagnoses.description.chakhohbili"), name2: "ჩახოხბილი", image: "Answer08.webp", description: I18n.t("diagnoses.description.chakhohbili2") }
    }


    @recipe_info = recipes[@recipe]
    @posts = Post.where(recipe: @recipe).includes(:user).page(params[:page]).per(9)

    @average_star = @posts.average(:star).to_f
  end


    def new
      @post = Post.new
    end

    def create
      @post = current_user.posts.build(post_params)
      @post.recipe = params[:recipe]

      if @post.save
        redirect_to posts_path(recipe: @post.recipe), success: t("defaults.flash_message.created", item: Post.model_name.human)
      else
        flash.now[:danger] = t("defaults.flash_message.not_created", item: Post.model_name.human)
        render :new, status: :unprocessable_entity
      end
    end

    def show
      @post = Post.find(params[:id])
      @comment = Comment.new
      @comments = @post.comments.includes(:user).order(created_at: :desc)
    end

    def edit
      @post = current_user.posts.find(params[:id])
    end



    def update
      @post = current_user.posts.find(params[:id])
     if @post.update(post_params)
      redirect_to post_path(@post), success: t("defaults.flash_message.updated", item: Post.model_name.human)
     else
      flash.now[:danger] = t("defaults.flash_message.not_updated", item: Post.model_name.human)
      render :edit, status: :unprocessable_entity
     end
    end


    def destroy
      @post = current_user.posts.find(params[:id])
       @post.destroy!
        redirect_to posts_path(recipe: @post.recipe), success: t("defaults.flash_message.deleted", item: Post.model_name.human), status: :see_other
    end


    def favorites
      @q = Post.joins(:favorites).where(favorites: { user_id: current_user.id }).ransack(params[:q])
      @favorite_posts = @q.result.page(params[:page]).per(9)
    end

    def posts
      @q = current_user.posts.ransack(params[:q])
      @user_posts = @q.result.page(params[:page]).per(9)
    end

    def autocomplete
     posts = Post.ransack(title_cont: params[:q]).result.limit(10)
     render json: posts.pluck(:title)
    end

    private

    def post_params
      params.require(:post).permit(:title, :body, :post_image, :post_image_cache, :star)
    end
end
