class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :name
      t.integer :position, :default => 1
      t.integer :site_id
      t.string :slug
      t.integer :parent_id

      t.timestamps
    end
  end
end
