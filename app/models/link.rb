class Link < ActiveRecord::Base
	belongs_to :site
	has_one :nav_item, :as =>:navable, :dependent => :destroy
  attr_accessible :name, :site_id, :url
end
