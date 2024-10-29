class FavoritesController < ApplicationController
    before_action :find_post

    def create
        post = Post.find(params[:post_id])
        favorite = @post.favorites.new(user: current_user)
        favorite.save
            redirect_to request.referer, success: t('.success') # リファラで前ページに戻る
    end

    def destroy
        post = Post.find(params[:post_id])
        favorite = @post.favorites.find_by(user: current_user)
            favorite.destroy
            redirect_to request.referer, success: t('.deleted') # リファラで前ページに戻る
    end

    private

    def find_post
        @post = Post.find(params[:post_id])
    end
end

