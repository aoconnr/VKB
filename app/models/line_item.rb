class LineItem < ActiveRecord::Base
  attr_accessible :unit_price, :item_id, :cart_id, :quantity, :cart, :item

  belongs_to :cart
  belongs_to :item
  
  def full_price
    unit_price * quantity
  end
end
