class AddIndexToLinks < ActiveRecord::Migration
  def change
  	add_index :links, :site_id
  end
end
