class CreateSales < ActiveRecord::Migration
  def change
    create_table :sales do |t|
    	t.string :name
    	t.string :set
    	t.integer :quantity
    	t.float :price
    	t.boolean :played
    	t.boolean :foil
    end
  end
end
