class OrderItem < ApplicationRecord
  belongs_to :book
  belongs_to :order

  validates :price, :quantity, presence: true

  after_destroy :update_totals
  delegate :update_totals, to: :order
  delegate :title, to: :book, prefix: true, allow_nil: true

  def subtotal
    quantity * price
  end
end
