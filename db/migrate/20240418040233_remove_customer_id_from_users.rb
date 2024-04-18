class RemoveCustomerIdFromUsers < ActiveRecord::Migration[7.1]
  def change
    remove_column :users, :customer_id, :integer
  end
end
