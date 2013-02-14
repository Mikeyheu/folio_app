class AddReverseElementableToElements < ActiveRecord::Migration
  def change
  	add_column :elements, :reverse_elementable_id, :integer
  	add_column :elements, :reverse_elementable_type, :string
  end
end
