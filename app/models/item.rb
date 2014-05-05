#coding: utf-8
class Item < ActiveRecord::Base
  attr_accessible :image, :name, :price, :category_id, :type_id
  mount_uploader :image, ImageUploader

  before_destroy :remember_id
  after_destroy :remove_image_directory 

  monetize :price, :as => "cost"

  validates :name, :presence => true
  validates :image, :presence => true
  validates :price, :presence => true
  validates :type_id, :presence => true
  validates_numericality_of :price, :greater_than_or_equal_to => 1, :message => "Cannot have a price less than £0.01"
  
  belongs_to :type, :inverse_of => :items

  def remember_id
    @id = id
  end

  def remove_image_directory
    FileUtils.remove_dir("#{Rails.root}/uploads/#{@id}", :force => true)
  end

end
