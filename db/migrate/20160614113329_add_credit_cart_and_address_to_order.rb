class AddCreditCartAndAddressToOrder < ActiveRecord::Migration[5.0]
  def change
    add_reference :orders, :credit_card, index: true, foreing_key: true
    add_reference :orders, :billing_address, index: true, foreing_key: true
    add_reference :orders, :shipping_address, index: true, foreing_key: true
    add_reference :orders, :shipment, index: true, foreing_key: true
  end
end
