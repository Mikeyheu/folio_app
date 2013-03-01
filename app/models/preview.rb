class Preview < ActiveRecord::Base
  attr_accessible :settings, :site_id
  belongs_to :site
end
