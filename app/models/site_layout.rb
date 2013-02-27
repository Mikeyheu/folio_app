class SiteLayout < ActiveRecord::Base
	belongs_to :site
  attr_accessible :name, :settings, :site_id
  serialize :settings, Hash
end
