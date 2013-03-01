class CreatePreviews < ActiveRecord::Migration
  def change
    create_table :previews do |t|
      t.integer :site_id
      t.integer :layout_id
      t.text :settings

      t.timestamps
    end
  end
end
