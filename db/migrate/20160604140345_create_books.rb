class CreateBooks < ActiveRecord::Migration[5.0]
  def change
    create_table :books do |t|
      t.string :title
      t.decimal :price, precision: 8, scale: 2
      t.integer :in_stock
      t.string :cover
      t.text :description

      t.timestamps
    end
  end
end
