class AddSiteIdToImages < ActiveRecord::Migration
  def change
  	add_column :images, :site_id, :integer
  	add_index :images, :site_id
  end
end
