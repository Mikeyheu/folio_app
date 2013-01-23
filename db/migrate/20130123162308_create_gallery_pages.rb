class CreateGalleryPages < ActiveRecord::Migration
  def change
    create_table :gallery_pages do |t|
      t.string :name
      t.integer :site_id

      t.timestamps
    end
    add_index :gallery_pages, :site_id
  end
end
