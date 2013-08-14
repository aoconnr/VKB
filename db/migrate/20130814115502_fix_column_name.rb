class FixColumnName < ActiveRecord::Migration
  def change
    rename_column :items, :description, :image
  end
end
