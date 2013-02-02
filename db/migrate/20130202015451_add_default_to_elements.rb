class AddDefaultToElements < ActiveRecord::Migration
  def change
  	change_column :elements, :image_width, :integer, :default => 200
  	change_column :elements, :image_height, :integer, :default => 200
  end
end
