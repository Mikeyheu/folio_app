class RemoveColumnsFromPages < ActiveRecord::Migration
  def up
  	remove_column :pages, :position
  	remove_column :pages, :parent_id
  end

  def down
  	add_column :pages, :position
  	add_column :pages, :parent_id
  end
end
