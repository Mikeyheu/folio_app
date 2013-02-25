class AddColumnToTemplates < ActiveRecord::Migration
  def change
  	add_column :templates, :image_url, :string
  end
end
