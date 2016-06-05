class CreateOrderItems < ActiveRecord::Migration[5.0]
  def change
    create_table :order_items do |t|
      t.decimal :price, precision: 8, scale: 2
      t.integer :quantity
      t.references :book, foreign_key: true, index: true

      t.timestamps
    end
  end
end
