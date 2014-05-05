class LineItem < ActiveRecord::Base
  attr_accessible :unit_price, :item_id, :cart_id, :quantity, :cart, :item

  belongs_to :cart
  belongs_to :item

  monetize :unit_price, :as => "cost"
  monetize :full_price, :as => "total_cost"

  def full_price
    unit_price * quantity
  end
end
