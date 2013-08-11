class PagesController < ApplicationController
	def index
		@items = Item.all
	end

  def admin
    render
  end
end