# == Schema Information
#
# Table name: templates
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Template < ActiveRecord::Base
	has_many :site_templates
	has_many :sites, through: :site_templates
  attr_accessible :name, :image_url, :settings
  serialize :settings, Hash
end
