class LineItemsController < ApplicationController

  def create
    @item = Item.find(params[:product_id])

    # Sets cart through def in application_controller
    @line_item = LineItem.create!(:cart => current_cart, :item => @item, :quantity => 1, :unit_price => @item.price)
    config.default_currency
    flash[:notice] = "Added #{@item.name} to cart."
    redirect_to current_cart_url
  end

  def destroy
    @line_item = LineItem.find(params[:id])

    @line_item.destroy
    redirect_to current_cart_url, notice: "#{@line_item.item.name} removed from cart" 
  end
end