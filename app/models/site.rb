# == Schema Information
#
# Table name: sites
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  slug       :string(255)
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Site < ActiveRecord::Base
  belongs_to :user
  has_one :setting
  has_one :homepage
  has_one :header
  accepts_nested_attributes_for :setting
  has_many :nav_items, :dependent => :destroy
  has_many :pages, :dependent => :destroy
  has_many :gallery_pages, :dependent => :destroy
  has_many :links, :dependent => :destroy
  has_many :folders, :dependent => :destroy
  has_many :galleries, :dependent => :destroy
  has_many :images, :dependent => :destroy
  has_one :site_template
  has_one :template, :through => :site_template

  
  extend FriendlyId
  friendly_id :name, use: :slugged

  validates_uniqueness_of :name, :case_sensitive => false
  validates_presence_of :name

  attr_accessible :name, :slug, :user_id
end
