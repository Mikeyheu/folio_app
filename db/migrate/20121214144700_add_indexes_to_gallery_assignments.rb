class AddIndexesToGalleryAssignments < ActiveRecord::Migration
  def change
  	add_index :gallery_assignments, :gallery_id
		add_index :gallery_assignments, :image_id
  end
end
