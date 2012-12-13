class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.string :name
      t.string :caption
      t.string :image_file

      t.timestamps
    end
  end
end
