class AddHotCountToBooks < ActiveRecord::Migration
  def change
    add_column :books, :hot_count, :integer
  end
end
