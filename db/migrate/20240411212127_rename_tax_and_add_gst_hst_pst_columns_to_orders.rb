class RenameTaxAndAddGstHstPstColumnsToOrders < ActiveRecord::Migration[7.1]
  def change
    rename_column :orders, :tax, :gst_tax
    add_column :orders, :hst_tax, :decimal
    add_column :orders, :pst_tax, :decimal
  end
end
