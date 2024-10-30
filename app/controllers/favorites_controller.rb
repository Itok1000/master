class FavoritesController < ApplicationController
    before_action :find_post

    def create
        post = Post.find(params[:post_id])
        favorite = post.favorites.build(user_id: current_user.id)
        favorite.save
        redirect_to request.referer, success: t(".success") # リファラで前ページに戻る
    end

    def destroy
        favorite = current_user.favorites.find(params[:id])
        favorite.destroy!
        redirect_to request.referer, success: t(".deleted") # リファラで前ページに戻る
    end

    private

    def find_post
        @post = Post.find(params[:post_id])
    end
end
