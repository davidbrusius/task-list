class ChangeTaskDescriptionType < ActiveRecord::Migration
  def change
    change_column :tasks, :description, :string
  end
end
