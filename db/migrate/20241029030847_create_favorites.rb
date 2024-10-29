class CreateFavorites < ActiveRecord::Migration[7.2]
  def change
    create_table :favorites do |t|
      t.integer :user_id
      t.integer :post_id

      t.timestamps
    end
    add_index :favorites, [:user_id, :post_id], unique: true
  end
end
