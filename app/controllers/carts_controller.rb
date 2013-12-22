class CartsController < ApplicationController
  def show
    # sets cart through definition in application_controller.rb
    @cart = current_cart
  end
end