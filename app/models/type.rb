class Type < ActiveRecord::Base 
  attr_accessible :name

  belongs_to :category, :inverse_of => :types
end