class Page < ActiveRecord::Base
	belongs_to :site
	has_many :subpages, :class_name => 'Page', :foreign_key => 'parent_id'
	belongs_to :parent, :class_name => 'Page'
  
  extend FriendlyId
  friendly_id :name, use: :slugged

  validates_uniqueness_of :name, :case_sensitive => false
  validates_presence_of :name

  attr_accessible :name, :parent_id, :position, :site_id, :slug
end
