# == Schema Information
#
# Table name: elements
#
#  id               :integer          not null, primary key
#  parent_id        :integer
#  position         :integer          default(0)
#  elementable_type :string(255)
#  elementable_id   :integer
#  page_id          :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  width            :integer          default(300)
#  height           :integer          default(300)
#  left             :integer          default(0)
#  top              :integer          default(0)
#  z_index          :integer          default(0)
#  image_width      :integer
#  image_height     :integer
#  image_top        :integer          default(0)
#  image_left       :integer          default(0)
#

class Element < ActiveRecord::Base
	belongs_to :elementable, :polymorphic => true
	belongs_to :child, :polymorphic => true, :dependent => :destroy
	belongs_to :parent, :class_name => 'Element'
	has_many :children, :class_name => 'Element', :foreign_key => 'parent_id'
  attr_accessible :elementable_id, :elementable_type, :page_id, :parent_id, :position, :elementable, :width, :height, :top, :left, :header_id, :child, :child_id, :child_type
  scope :pos, order("elements.position ASC")
end
