class UpdateFksWithoutDeleteCascadeOnTask < ActiveRecord::Migration
  def change
    remove_foreign_key :tasks, :lists
    add_foreign_key :tasks, :lists, on_delete: :cascade
  end
end
