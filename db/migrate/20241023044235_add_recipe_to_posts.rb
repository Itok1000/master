class AddRecipeToPosts < ActiveRecord::Migration[7.2]
  def change
    add_column :posts, :recipe, :string
  end
end
