class AddIndexToSites < ActiveRecord::Migration
  def change
  	add_index :sites, :user_id
  end
end
