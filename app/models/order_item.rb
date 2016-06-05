class OrderItem < ApplicationRecord
  belongs_to :book

  validates :price, :quantity, presence: true
end
