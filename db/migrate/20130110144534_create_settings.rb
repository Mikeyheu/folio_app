class CreateSettings < ActiveRecord::Migration
  def change
    create_table :settings do |t|
      t.integer :site_id
      t.string :title
      t.text :meta_description
      t.text :meta_keywords

      t.timestamps
    end
  end
end
