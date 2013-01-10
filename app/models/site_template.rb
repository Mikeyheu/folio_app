class SiteTemplate < ActiveRecord::Base
	belongs_to :site
	belongs_to :template
  attr_accessible :site_id, :template_id
end
