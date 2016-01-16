class AddBnToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :BN, :string
  end
end
