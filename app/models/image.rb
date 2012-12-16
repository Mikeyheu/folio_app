class Image < ActiveRecord::Base
	belongs_to :site
  has_many :gallery_assignments
  has_many :galleries, :through => :gallery_assignments
  attr_accessible :caption, :image_file, :name
  mount_uploader :image_file, ImageFileUploader
end
