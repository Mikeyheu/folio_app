class CreateElements < ActiveRecord::Migration
  def change
    create_table :elements do |t|
      t.integer :parent_id
      t.integer :position, :default => 0
      t.string :elementable_type
      t.integer :elementable_id
      t.integer :page_id

      t.timestamps
    end
    add_index :elements, [:elementable_id, :elementable_type, :page_id], :unique => true, :name => 'element_index'
  end
end
