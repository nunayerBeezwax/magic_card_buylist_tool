class AddFoilToCards < ActiveRecord::Migration
  def change
  	add_column :cards, :foil, :boolean
  end
end
