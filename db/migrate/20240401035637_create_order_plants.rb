class CreateOrderPlants < ActiveRecord::Migration[7.1]
  def change
    create_table :order_plants do |t|
      t.integer :quantity
      t.decimal :price
      t.references :order, null: false, foreign_key: true
      t.references :plant, null: false, foreign_key: true

      t.timestamps
    end
  end
end
