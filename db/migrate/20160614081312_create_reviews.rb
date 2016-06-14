class CreateReviews < ActiveRecord::Migration[5.0]
  def change
    create_table :reviews do |t|
      t.string :body
      t.integer :rating
      t.boolean :approved, null: false, default: false
      t.references :book, foreign_key: true, index: true

      t.timestamps
    end
  end
end
