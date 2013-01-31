# == Schema Information
#
# Table name: gallery_assignments
#
#  id         :integer          not null, primary key
#  gallery_id :integer
#  image_id   :integer
#  position   :integer          default(1)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class GalleryAssignment < ActiveRecord::Base
  belongs_to :gallery
  belongs_to :image
  attr_accessible :gallery_id, :image_id, :position 
  # acts_as_list :scope => :gallery # this needs to be checked if needed for improved performance
end
