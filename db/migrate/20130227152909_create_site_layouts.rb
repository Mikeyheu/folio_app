class CreateSiteLayouts < ActiveRecord::Migration
  def change
    create_table :site_layouts do |t|
      t.string :name
      t.integer :site_id
      t.text :settings

      t.timestamps
    end
  end
end
