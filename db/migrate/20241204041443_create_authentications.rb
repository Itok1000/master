class CreateAuthentications < ActiveRecord::Migration[7.2]
  def change
    create_table :authentications do |t|
      t.references :user, null: false, foreign_key: true
      t.string :provider, null: false
      t.string :uid, null: false

      t.timestamps
    end
  end
end
