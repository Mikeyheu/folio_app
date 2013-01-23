class Gallery < ActiveRecord::Base
  belongs_to :site
  has_one :nav_item, :as =>:navable, :dependent => :destroy
  has_many :gallery_assignments, :dependent => :destroy
  has_many :images, :through => :gallery_assignments, :order => 'gallery_assignments.position'
  
  extend FriendlyId
  friendly_id :name, use: :slugged

  validates_presence_of :name
  attr_accessible :name, :site_id, :slug
end

