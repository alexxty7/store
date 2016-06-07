class Order < ApplicationRecord
  include AASM

  validates :state, presence: true

  belongs_to :user
  has_many :order_items, dependent: :destroy

  after_update :update_totals
  
  delegate :clear, :empty?, to: :order_items

  aasm column: :state do
    state :in_progress, initial: true
    state :in_queue
    state :in_delivery
    state :delivered
    state :canceled

    event :place_order do
      transitions from: :in_progress, to: :in_queue
    end

    event :shipping do
      transitions from: :in_queue, to: :in_delivery
    end

    event :shipped do
      transitions from: :in_delivery, to: :delivered 
    end

    event :cancel do
      transitions from: [:in_progress, :in_queue], to: :canceled 
    end
  end

  def add(item, quantity = 1)
    order_item = order_items.find_by(book: item)
    if order_item
      order_item.quantity += quantity
      order_item.save
    else
      order_items.create(price: item.price, quantity: quantity, book: item)
    end
    update_totals
  end

  def update_totals
    update_columns(
      total: calc_total, 
      subtotal: calc_subtotal
    )
  end
 
 private

  def calc_subtotal
    order_items.inject(0) { |a, e| a + (e.price * e.quantity) }
  end

  # def calc_shipment_total
  #   delivery ? delivery.price : 0
  # end

  def calc_total
    calc_subtotal
  end
end
