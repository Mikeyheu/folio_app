# == Schema Information
#
# Table name: images
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  caption    :string(255)
#  image_file :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  site_id    :integer
#

class Image < ActiveRecord::Base
	belongs_to :site
	has_one :element, :as =>:elementable, :dependent => :destroy
  has_many :gallery_assignments, :dependent => :destroy
  has_many :galleries, :through => :gallery_assignments
  attr_accessible :caption, :image_file, :name
  mount_uploader :image_file, ImageFileUploader
end
