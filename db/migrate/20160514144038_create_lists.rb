class CreateLists < ActiveRecord::Migration
  def change
    create_table :lists do |t|
      t.string :subject, null: false
      t.boolean :public_access, default: false

      t.timestamps null: false
    end
  end
end
