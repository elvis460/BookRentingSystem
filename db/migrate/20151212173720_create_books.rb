class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :name
      t.string :BN
      t.boolean :borrowed
      t.integer :category_id

      t.timestamps null: false
    end
  end
end
