class Header < ActiveRecord::Base
  belongs_to :site
	# has_many :elements, :dependent => :destroy
	has_many :elements, :as =>:elementable, :dependent => :destroy
  attr_accessible :height, :site_id, :width
end
