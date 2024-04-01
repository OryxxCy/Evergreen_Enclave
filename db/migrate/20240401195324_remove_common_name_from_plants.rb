class RemoveCommonNameFromPlants < ActiveRecord::Migration[7.1]
  def change
    remove_column :plants, :common_name, :string
  end
end
