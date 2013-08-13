#coding: utf-8
class Item < ActiveRecord::Base
  attr_accessible :description, :name, :price

  monetize :price, :as => "cost"

end
