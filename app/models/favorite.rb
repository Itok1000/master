class Favorite < ApplicationRecord
    # User（ユーザー）とFavorite（いいね）の関係は、1対多の関係 1人のユーザーが複数のいいねを持つことができる
    belongs_to :user
    # Book（投稿）とFavorite（いいね）の関係も、1対多の関係 1つの投稿が複数のいいねを持つことができる
    belongs_to :post

    # 1人のユーザーは1回までのいいねにするため
    validates :user_id, uniqueness: { scope: :post_id }
end
# つまり、ユーザーといいねの関係は「1:N」であり、投稿といいねの関係も「1:N」
