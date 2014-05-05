class PagesController < ApplicationController
	def index
		@items = Item.all
    @categories = Category.all
    @types = Type.all
	end

  def admin
    render
  end

  def category
    @category = Category.find(params[:id])
    @items = Array.new
    @category.types.each do |type| 
      newItem = Item.find { |i| i.type == type  }
      unless newItem.nil?
        @items << newItem 
      end
    end
  end

  def type
    @type = Type.find(params[:id])
    @items = @type.items
  end

end