class Folder < ActiveRecord::Base
	belongs_to :site
	has_many :nav_items, :as =>:navable, :dependent => :destroy
  attr_accessible :name, :site_id
end
