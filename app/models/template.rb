class Template < ActiveRecord::Base
	has_many :sites, :through => :site_templates
	has_many :site_templates
  attr_accessible :name
end
