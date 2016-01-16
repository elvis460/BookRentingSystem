class CreateBookRents < ActiveRecord::Migration
  def change
    create_table :book_rents do |t|
      t.integer :book_id
      t.integer :user_id
      t.string :dead_line
      t.boolean :borrowed
      t.integer :extra_fee

      t.timestamps null: false
    end
  end
end
