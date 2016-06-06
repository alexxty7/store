class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      t.string :number
      t.decimal :total, precision: 8, scale: 2
      t.decimal :subtotal, precision: 8, scale: 2
      t.decimal :shipment_total, precision: 8, scale: 2
      t.string :state
      t.datetime :completed_at

      t.timestamps
    end
  end
end
