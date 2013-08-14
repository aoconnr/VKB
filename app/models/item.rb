#coding: utf-8
class Item < ActiveRecord::Base
  attr_accessible :image, :name, :price
  mount_uploader :image, ImageUploader

  before_destroy :remember_id
  after_destroy :remove_image_directory 

  monetize :price, :as => "cost"

  has_one :type

  def remember_id
    @id = id
  end

  def remove_image_directory
    FileUtils.remove_dir("#{Rails.root}/uploads/#{@id}", :force => true)
  end
end
