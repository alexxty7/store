class CreateCreditCards < ActiveRecord::Migration[5.0]
  def change
    create_table :credit_cards do |t|
      t.string :number
      t.string :cvv
      t.string :month
      t.string :year
      t.string :firstname
      t.string :lastname

      t.timestamps
    end
  end
end
