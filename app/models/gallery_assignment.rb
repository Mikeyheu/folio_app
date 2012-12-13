class GalleryAssignment < ActiveRecord::Base
  belongs_to :gallery
  belongs_to :image
  attr_accessible :gallery_id, :image_id, :position
end
