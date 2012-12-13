class Image < ActiveRecord::Base
	has_many :gallery_assignments
  has_many :galleries, :through => :gallery_assignments
  attr_accessible :caption, :image_file, :name
end
