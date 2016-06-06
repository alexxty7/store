class OrderItem < ApplicationRecord
  belongs_to :book
  belongs_to :order
  
  validates :price, :quantity, presence: true
end
