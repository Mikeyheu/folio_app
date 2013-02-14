class CreateHeaders < ActiveRecord::Migration
  def change
    create_table :headers do |t|
      t.integer :site_id
      t.integer :width
      t.integer :height

      t.timestamps
    end
  end
end
