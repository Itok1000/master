class SorceryExternal < ActiveRecord::Migration[7.2]
  def change
    # まずテーブルが存在しないか確認して、存在しなければ新しくテーブルを作成してる。
    unless table_exists?(:authentications)
      create_table :authentications do |t|
        t.integer :user_id, null: false
        t.string :provider, :uid, null: false
        t.timestamps null: false
      end
    end
    # さらに、インデックスの追加もチェックしている
    add_index :authentications, [:provider, :uid] unless index_exists?(:authentications, [:provider, :uid])
  end
end
