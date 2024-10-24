class AddPostImageToPosts < ActiveRecord::Migration[7.2]
  def change
    add_column :posts, :post_image, :string
  end
end

# Postsテーブルにpost_imageという名前のカラムを追加するための記述
# カラムのデータ型はstringであり、画像のファイルパスを保存するのに使用される
# マイグレーションを実行することで、データベースのテーブル構造が変更され、board_imageカラムが新たに追加される
# これにより、各掲示板の投稿に対して画像ファイルを関連付けることが可能になる
