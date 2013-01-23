class GalleryPage < ActiveRecord::Base
	belongs_to :site
	has_one :gallery
	has_one :nav_item, :as =>:navable, :dependent => :destroy

  attr_accessible :name, :site_id
end
