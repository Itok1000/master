# FavoriteモデルがUserモデルとPostモデルに対してそれぞれ1対多の関連付けを持つことを表す
class Like < ApplicationRecord
    belongs_to :user
    belongs_to :post
end
# User（ユーザー）とLike（いいね）の関係は、1対多の関係
# 1人のユーザーが複数のいいねを持つことができる
# Post（投稿）とLike（いいね）の関係も、1対多の関係
# 1つの投稿が複数のいいねを持つことができる
# つまり、ユーザーといいねの関係は「1:N」であり、投稿といいねの関係も「1:N」