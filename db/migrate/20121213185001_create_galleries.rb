class CreateGalleries < ActiveRecord::Migration
  def change
    create_table :galleries do |t|
      t.string :name
      t.string :slug
      t.integer :site_id

      t.timestamps
    end
    add_index :galleries, :site_id
  end
end
