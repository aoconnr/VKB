class PagesController < ApplicationController
	def index
		@items = Item.all
    @categories = Category.all
    @types = Type.all
	end

  def admin
    render
  end
end