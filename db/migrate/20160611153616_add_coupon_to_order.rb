class AddCouponToOrder < ActiveRecord::Migration[5.0]
  def change
    add_reference :orders, :coupon, foreign_key: true, index: true
  end
end
