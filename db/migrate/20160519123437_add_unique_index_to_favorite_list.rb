class AddUniqueIndexToFavoriteList < ActiveRecord::Migration
  def change
    add_index :favorite_lists, [:user_id, :list_id], unique: true
  end
end
