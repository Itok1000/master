class SorceryCore < ActiveRecord::Migration[7.2]
  def change
    # create_tableから1つ目のendまでの部分で、t.の直後に記述されるのがカラムの型
    # その後に続くのがカラム名
    # 例⇒t.string :emailは、string型のemailカラムを意味する
    create_table :users do |t|
      # ●null: falseについて
      # データベースの該当カラムにNULL制約（NULL値の保存を許容しない）を設けるための記述
      t.string :email,            null: false, index: { unique: true }
      # ●index: { unique: true }について
      # データベースの該当カラムにインデックスを設定し、ユニーク制約（重複する値の保存を許容しない）を加える記述
      # データベースのインデックスは、特定のカラムのデータを迅速に検索するために使用される
      t.string :crypted_password
      t.string :salt
      t.string :user_name,       null: false

      t.timestamps                null: false
    end
  end
end
