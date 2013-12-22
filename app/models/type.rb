class Type < ActiveRecord::Base 
  attr_accessible :name, :category_id

  belongs_to :category, :inverse_of => :types
  has_many :items
end