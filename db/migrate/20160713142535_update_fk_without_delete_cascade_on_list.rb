class UpdateFkWithoutDeleteCascadeOnList < ActiveRecord::Migration
  def change
    remove_foreign_key :lists, :user
    add_foreign_key    :lists, :users, on_delete: :cascade
  end
end
