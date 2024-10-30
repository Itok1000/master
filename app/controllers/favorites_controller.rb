class FavoritesController < ApplicationController
    before_action :find_post
    # いいねをするメソッド
    def create
        post = Post.find(params[:post_id])
        # 　投稿の新規いいねを現在ログインしているユーザーにセットする
        favorite = @post.favorites.new(user: current_user)
        # いいねすると、「いいねしました」とフラッシュメッセージを放つ
        favorite.save
            redirect_to request.referer, success: t(".success") # リファラで前ページに戻る
    end
    # いいねを取り消しするメソッド
    def destroy
        post = Post.find(params[:post_id])
        # 　投稿のいいねを現在ログインしているユーザーに基づいて探す
        favorite = @post.favorites.find_by(user: current_user)
            # いいねを取り消しすると、「いいねを取り消しました」とフラッシュメッセージを放つ
            favorite.destroy
            redirect_to request.referer, success: t(".deleted") # リファラで前ページに戻る
    end

    private
    def find_post
        @post = Post.find(params[:post_id])
    end
end
