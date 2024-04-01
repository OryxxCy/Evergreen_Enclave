class CreateOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :orders do |t|
      t.integer :total
      t.date :date
      t.references :customer, null: false, foreign_key: true

      t.timestamps
    end
  end
end
