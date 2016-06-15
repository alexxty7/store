class Order < ApplicationRecord
  include Checkout

  validates :state, presence: true

  belongs_to :user
  belongs_to :coupon

  has_many :order_items, dependent: :destroy
  accepts_nested_attributes_for :order_items
  after_update :update_totals

  delegate :clear, :empty?, to: :order_items

  attr_accessor :coupon_code
  before_validation :set_coupon, if: 'coupon_code.present?'

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
      subtotal: calc_subtotal,
      shipment_total: calc_shipment_total
    )
  end

  def set_coupon
    coupon = Coupon.find_by(code: coupon_code)
    if coupon && !coupon.expired?
      self.coupon = coupon
    else
      errors.add(:base, 'Invalid coupon code')
    end
  end

  private

  def calc_subtotal
    order_items.inject(0) { |a, e| a + (e.price * e.quantity) }
  end

  def calc_shipment_total
    shipment ? shipment.price : 0
  end
  
  def coupon_discount
    coupon ? coupon.discount : 0
  end

  def calc_total
    calc_subtotal + calc_shipment_total - coupon_discount
  end
end
