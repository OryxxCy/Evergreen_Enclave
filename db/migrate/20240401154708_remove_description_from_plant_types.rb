class RemoveDescriptionFromPlantTypes < ActiveRecord::Migration[7.1]
  def change
    remove_column :plant_types, :description, :string
  end
end
