class Category < ActiveRecord::Base
  attr_accessible :name

  has_many :types, :dependent => :destroy, :inverse_of => :category
  accepts_nested_attributes_for :types

  has_many :items
end
