# == Schema Information
#
# Table name: homepages
#
#  id         :integer          not null, primary key
#  name       :string(255)      default("Home")
#  site_id    :integer
#  slug       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Homepage < ActiveRecord::Base
	belongs_to :site
	has_one :nav_item, :as =>:navable, :dependent => :destroy
	has_many :elements, :dependent => :destroy
  
  extend FriendlyId
  friendly_id :name, use: :slugged

  validates_presence_of :name
  attr_accessible :name, :site_id, :slug
end
