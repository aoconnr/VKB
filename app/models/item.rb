#coding: utf-8
class Item < ActiveRecord::Base
  attr_accessible :image, :name, :price
  mount_uploader :image, ImageUploader

  before_destroy :remember_image
  after_destroy :remove_image_directory 

  monetize :price, :as => "cost"

  has_one :type

  def remember_image
    @image = image
  end

  def remove_image_directory
    FileUtils.remove_dir("#{Rails.root}/public/images/#{@image}", :force => true)
  end
end
