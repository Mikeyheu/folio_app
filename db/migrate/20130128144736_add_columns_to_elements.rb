class AddColumnsToElements < ActiveRecord::Migration
  def change
  	add_column :elements, :width, :integer, :default => 300
  	add_column :elements, :height, :integer, :default => 300
  end
end
