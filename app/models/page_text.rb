class PageText < ActiveRecord::Base
	has_one :element, :as =>:elementable, :dependent => :destroy
  attr_accessible :content
end
