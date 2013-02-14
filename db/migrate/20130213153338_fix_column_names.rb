class FixColumnNames < ActiveRecord::Migration
  def change
  	rename_column :elements, :elementable_id, :child_id
  	rename_column :elements, :elementable_type, :child_type
  	rename_column :elements, :reverse_elementable_id, :elementable_id
  	rename_column :elements, :reverse_elementable_type, :elementable_type
  end
end
