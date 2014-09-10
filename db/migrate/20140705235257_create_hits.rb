class CreateHits < ActiveRecord::Migration
  def change
    create_table :hits do |t|
    	t.belongs_to :card
    	t.belongs_to :buycard
    	t.integer :quantity
    	t.float :price
    end
  end
end
