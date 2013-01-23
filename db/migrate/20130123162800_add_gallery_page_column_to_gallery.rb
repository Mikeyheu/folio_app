class AddGalleryPageColumnToGallery < ActiveRecord::Migration
  def change
  	add_column :galleries, :gallery_page_id, :integer
  end
end