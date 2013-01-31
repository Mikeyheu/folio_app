class AddSizesToElements < ActiveRecord::Migration
  def change
  	add_column :elements, :z_index, :integer, :default => 0
  	add_column :elements, :image_width, :integer
  	add_column :elements, :image_height, :integer
  	add_column :elements, :image_top, :integer, :default => 0
  	add_column :elements, :image_left, :integer, :default => 0
  end
end
