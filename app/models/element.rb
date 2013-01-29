class Element < ActiveRecord::Base
	belongs_to :elementable, :polymorphic => true
	belongs_to :page
	belongs_to :parent, :class_name => 'Element'
	has_many :children, :class_name => 'Element', :foreign_key => 'parent_id'
  attr_accessible :elementable_id, :elementable_type, :page_id, :parent_id, :position, :elementable, :width, :height, :top, :left
  scope :pos, order("elements.position ASC")
end
