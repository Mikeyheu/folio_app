class AddHeaderIdToElements < ActiveRecord::Migration
  def change
  	add_column :elements, :header_id, :integer
  	add_index :elements, :header_id
  end

end
