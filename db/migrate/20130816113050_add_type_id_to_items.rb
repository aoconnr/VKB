class AddTypeIdToItems < ActiveRecord::Migration
  def change
    add_column :items, :category_id, :integer
    add_column :items, :type_id, :integer
  end
end
