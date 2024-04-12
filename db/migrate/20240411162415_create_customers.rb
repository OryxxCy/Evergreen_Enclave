class CreateCustomers < ActiveRecord::Migration[7.1]
  def change
    create_table :customers do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :address
      t.references :tax_rate, null: false, foreign_key: true

      t.timestamps
    end
  end
end
