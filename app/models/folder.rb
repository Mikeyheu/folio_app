# == Schema Information
#
# Table name: folders
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  site_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Folder < ActiveRecord::Base
	belongs_to :site
	has_one :nav_item, :as =>:navable, :dependent => :destroy
  attr_accessible :name, :site_id
end
