class Setting < ActiveRecord::Base
	belongs_to :site
  attr_accessible :meta_description, :meta_keywords, :site_id, :title
end
