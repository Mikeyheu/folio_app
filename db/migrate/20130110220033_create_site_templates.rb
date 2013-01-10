class CreateSiteTemplates < ActiveRecord::Migration
  def change
    create_table :site_templates do |t|
      t.integer :site_id
      t.integer :template_id

      t.timestamps
    end
  end
end
