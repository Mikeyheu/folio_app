# == Schema Information
#
# Table name: page_texts
#
#  id         :integer          not null, primary key
#  content    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class PageText < ActiveRecord::Base
	has_one :element, :as =>:elementable, :dependent => :destroy
  attr_accessible :content
end
