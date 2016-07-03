class AddDefaultValueToOrder < ActiveRecord::Migration[5.0]
  def change
    change_column_default :orders, :total, 0.0
    change_column_default :orders, :subtotal, 0.0
    change_column_default :orders, :shipment_total, 0.0
  end
end
