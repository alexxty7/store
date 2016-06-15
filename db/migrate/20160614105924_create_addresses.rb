class CreateAddresses < ActiveRecord::Migration[5.0]
  def change
    create_table :addresses do |t|
      t.string :firstname
      t.string :lastname
      t.string :address
      t.string :city
      t.references :country, foreign_key: true, index: true
      t.string :phone
      t.string :zipcode

      t.timestamps
    end
  end
end
