class CreateNavItems < ActiveRecord::Migration
  def change
    create_table :nav_items do |t|
      t.integer :site_id
      t.string :navable_type
      t.integer :navable_id
      t.integer :position, :default => 0
      t.integer :parent_id

      t.timestamps
    end
    add_index :nav_items, [:navable_id, :navable_type, :site_id]
  end
end
