# == Schema Information
#
# Table name: settings
#
#  id               :integer          not null, primary key
#  site_id          :integer
#  title            :string(255)
#  meta_description :text
#  meta_keywords    :text
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class Setting < ActiveRecord::Base
	belongs_to :site
  attr_accessible :meta_description, :meta_keywords, :site_id, :title
end
