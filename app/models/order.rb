class Order < ApplicationRecord
  include AASM

  belongs_to :credit_card
  belongs_to :billing_address, class_name: 'Address'
  belongs_to :shipping_address, class_name: 'Address'
  belongs_to :shipment
  belongs_to :user
  belongs_to :coupon
  has_many :order_items, dependent: :destroy

  accepts_nested_attributes_for :order_items

  validates :state, presence: true

  before_validation :set_coupon, if: 'coupon_code.present?'
  after_update :update_totals

  delegate :clear, :empty?, to: :order_items

  attr_accessor :coupon_code

  aasm column: :state, whiny_transitions: false do
    state :in_progress, initial: true
    state :in_queue, after_enter: :set_completed_time_and_number
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

  def self.in_progress
    find_by(state: 'in_progress')
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
      total: order_calculator.total,
      subtotal: order_calculator.subtotal,
      shipment_total: order_calculator.shipment_total
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

  def set_completed_time_and_number
    touch(:completed_at)
    update(number: order_number)
  end

  private

  def order_number
    'R-%.6d' % id
  end

  def order_calculator
    @calculator ||= OrderCalculator.new(self)
  end
end
