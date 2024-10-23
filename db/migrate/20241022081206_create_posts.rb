class CreatePosts < ActiveRecord::Migration[7.2]
  def change
    # create_table :postsブロック内では、テーブルに含まれるカラムを定義
    create_table :posts do |t|
      t.string :title, null: false # titleカラム：string型。nullを許容しない設定。
      t.text :body, null: false # bodyカラム：text型。nullを許容しない設定
      # references
      # 外部キーを設定するためのメソッド
      # このメソッドを使用することで、BoardsテーブルとUsersテーブルを関連付けることができる
      # foreign_key: true オプションを指定することで、外部キー制約を設定

      # 外部キー制約
      # あるテーブルのカラムの値が、他のテーブルの特定のカラムの値と一致することを強制するデータベースの仕組み
      # この制約を設定することで、データベースの整合性を保ち、不整合なデータの挿入を防ぐ
      # 例えば、Boards テーブルの user_id カラムに外部キー制約を設定することで、その user_id が必ず Users テーブルの id カラムに存在することを保証する
      t.references :user, foreign_key: true # user_idカラム：外部キーとしてUserモデルと関連付ける設定

      t.timestamps
    end
  end
end

# Postsテーブルを作成するための記述している
# ●string型とtext型の違い
# - string型
# - 長さ: 255文字までの文字列を扱う
# - text型
# - 長さ: 65,535文字までの文字列を扱う
