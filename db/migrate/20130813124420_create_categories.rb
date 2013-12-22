class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name
    end

    create_table :types do |t|
      t.string :name
      t.integer :category_id
    end
  end
end
