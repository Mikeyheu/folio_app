class CreateHomepages < ActiveRecord::Migration
  def change
    create_table :homepages do |t|
      t.string :name, :default => 'Home'
      t.integer :site_id
      t.string :slug

      t.timestamps
    end
    add_index :homepages, :site_id
  end
end
