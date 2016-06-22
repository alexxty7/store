class AddFullDescriptionToBook < ActiveRecord::Migration[5.0]
  def change
    add_column :books, :full_description, :text
  end
end
