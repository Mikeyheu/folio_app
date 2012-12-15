class GalleryAssignment < ActiveRecord::Base
  belongs_to :gallery
  belongs_to :image
  attr_accessible :gallery_id, :image_id, :position 
  acts_as_list :scope => :gallery # this needs to be checked for accuracy
end
