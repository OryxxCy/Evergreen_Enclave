class AddCommonNameToPlants < ActiveRecord::Migration[7.1]
  def change
    add_column :plants, :common_name, :string
  end
end
