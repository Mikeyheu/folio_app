class AddNavToNavItem < ActiveRecord::Migration
  def change
  	add_column :nav_items, :nav, :boolean
  end
end
