class CreatePlants < ActiveRecord::Migration[7.1]
  def change
    create_table :plants do |t|
      t.string :name
      t.string :description
      t.decimal :price
      t.references :plant_type, null: false, foreign_key: true

      t.timestamps
    end
  end
end
