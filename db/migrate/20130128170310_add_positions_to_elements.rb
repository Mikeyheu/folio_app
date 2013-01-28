class AddPositionsToElements < ActiveRecord::Migration
  def change
  	add_column :elements, :left, :integer, :default => 0
  	add_column :elements, :top, :integer, :default => 0
  end
end
