class CreateCoupons < ActiveRecord::Migration[5.0]
  def change
    create_table :coupons do |t|
      t.string :code
      t.date :expires_at
      t.date :starts_at
      t.decimal :discount, precision: 8, scale: 2, default: 0.0

      t.timestamps
    end
  end
end
