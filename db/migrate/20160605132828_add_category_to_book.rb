class AddCategoryToBook < ActiveRecord::Migration[5.0]
  def change
    add_reference :books, :category, foreign_key: true, index: true
  end
end
