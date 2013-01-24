class NavItem < ActiveRecord::Base
	belongs_to :site
	belongs_to :parent, :class_name => 'NavItem'
	has_many :children, :class_name => 'NavItem', :foreign_key => 'parent_id'
	belongs_to :navable, :polymorphic => true
  attr_accessible :navable_id, :navable_type, :parent_id, :position, :site_id, :navable, :nav

  scope :nav_scope, where(:nav => true).order("nav_items.position ASC")
  scope :gallery_scope, where(:nav => false).order("nav_items.position ASC")
end
