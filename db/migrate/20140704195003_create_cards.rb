class CreateCards < ActiveRecord::Migration
  def change
    create_table :cards do |t|
    	t.string :set
    	t.string :name
    	t.string :rarity
    	t.string :condition
    	t.float :price
    	t.integer :quantity
    end
  end
end
