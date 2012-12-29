class Site < ActiveRecord::Base
  belongs_to :user
  has_many :nav_items, :dependent => :destroy
  has_many :pages, :dependent => :destroy
  has_many :galleries, :dependent => :destroy
  has_many :images, :dependent => :destroy
  
  extend FriendlyId
  friendly_id :name, use: :slugged

  validates_uniqueness_of :name, :case_sensitive => false
  validates_presence_of :name

  attr_accessible :name, :slug, :user_id
end
