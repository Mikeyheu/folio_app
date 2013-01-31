# == Schema Information
#
# Table name: site_templates
#
#  id          :integer          not null, primary key
#  site_id     :integer
#  template_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class SiteTemplate < ActiveRecord::Base
	belongs_to :site
	belongs_to :template
  attr_accessible :site_id, :template_id
end
