class AddCart < ActiveRecord::Migration
  def change
    create_table :carts do |t|
      t.datetime :purchased_at
      t.timestamps
    end

    create_table :line_items do |t|
      t.integer :unit_price
      t.integer :item_id
      t.integer :cart_id
      t.integer :quantity
      t.timestamps
    end
  end
end
