class AddOtherNameToPlants < ActiveRecord::Migration[7.1]
  def change
    add_column :plants, :other_name, :string
  end
end
