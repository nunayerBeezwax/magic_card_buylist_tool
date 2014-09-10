class CreateBuycards < ActiveRecord::Migration
  def change
    create_table :buycards do |t|
    	t.string :set
    	t.string :name
    	t.boolean :foil
    	t.boolean :played
    	t.float :price
    	t.integer :quantity
    end
  end
end
