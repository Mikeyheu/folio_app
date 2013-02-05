class AddStyleToPageText < ActiveRecord::Migration
  def change
  	add_column :page_texts, :style, :text, :default => ""
  end
end
