class AddSettingsToTemplate < ActiveRecord::Migration
  def change
  	add_column :templates, :settings, :text
  end
end
