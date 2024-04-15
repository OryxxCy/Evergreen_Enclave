class AddStockToPlants < ActiveRecord::Migration[7.1]
  def change
    add_column :plants, :stock, :integer
  end
end
