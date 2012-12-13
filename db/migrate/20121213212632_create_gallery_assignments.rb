class CreateGalleryAssignments < ActiveRecord::Migration
  def change
    create_table :gallery_assignments do |t|
      t.integer :gallery_id
      t.integer :image_id
      t.integer :position, :default => 1

      t.timestamps
    end
  end
end
