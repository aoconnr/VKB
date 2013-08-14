class Category < ActiveRecord::Base
  attr_accessible :name

  has_many :types, :dependent => :destroy, :inverse_of => :category
end
