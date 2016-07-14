class UpdateFksWithoutDeleteCascadeOnFavoriteList < ActiveRecord::Migration
  def change
    remove_foreign_key :favorite_lists, :lists
    remove_foreign_key :favorite_lists, :users
    add_foreign_key :favorite_lists, :lists, on_delete: :cascade
    add_foreign_key :favorite_lists, :users, on_delete: :cascade
  end
end
