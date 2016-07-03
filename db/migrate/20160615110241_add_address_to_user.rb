class AddAddressToUser < ActiveRecord::Migration[5.0]
  def change
    add_reference :users, :billing_address, index: true, foreing_key: true
    add_reference :users, :shipping_address, index: true, foreing_key: true
  end
end
