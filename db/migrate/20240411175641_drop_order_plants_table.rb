class DropOrderPlantsTable < ActiveRecord::Migration[7.1]
  def change
    drop_table :order_plants
  end
end
