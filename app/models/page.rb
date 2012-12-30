class Page < ActiveRecord::Base
	belongs_to :site
	has_many :nav_items, :as =>:navable
  
  extend FriendlyId
  friendly_id :name, use: :slugged

  validates_uniqueness_of :name, :case_sensitive => false
  validates_presence_of :name

  attr_accessible :name, :site_id, :slug
end
