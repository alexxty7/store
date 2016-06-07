class OrderItem < ApplicationRecord
  belongs_to :book
  belongs_to :order
  
  validates :price, :quantity, presence: true

  def subtotal
    quantity * price
  end
end
