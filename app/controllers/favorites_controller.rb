class FavoritesController < ApplicationController
    before_action :find_post
    def create
        post = Post.find(params[:post_id])
        favorite = @post.favorites.new(user: current_user)
        favorite.save
            redirect_to request.referer 
    end

    def destroy
        post = Post.find(params[:post_id])

        favorite = @post.favorites.find_by(user: current_user)
            favorite.destroy
            redirect_to request.referer
    end

    private
    def find_post
        @post = Post.find(params[:post_id])
    end
end
