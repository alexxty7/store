module Checkout
  extend ActiveSupport::Concern

  included do
    include AASM

    belongs_to :credit_card
    belongs_to :billing_address, class_name: 'Address'
    belongs_to :shipping_address, class_name: 'Address'
    belongs_to :shipment

    accepts_nested_attributes_for :billing_address
    accepts_nested_attributes_for :shipping_address
    accepts_nested_attributes_for :credit_card

    before_validation :clone_billing_address, if: :use_billing?
    attr_accessor :use_billing

    aasm column: :state do
      state :in_progress, initial: true
      state :in_queue, after_enter: :set_completed_time
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
  end

  def set_completed_time
    touch(:completed_at)
  end

  def use_billing?
    use_billing.in?([true, 'true', '1'])
  end

  def clone_billing_address
    if billing_address && shipping_address.nil?
      self.shipping_address = billing_address.clone
    else
      shipping_address.attributes = billing_address.attributes.except('id', 'updated_at', 'created_at')
    end
    true
  end

  def setup_for_step(step)
    case step
    when :address then build_address
    when :payment then build_credit_cart
    when :complete then place_order!
    end
  end

  def build_address
    self.billing_address ||= user.try(:billing_address) || Address.new
    self.shipping_address ||= user.try(:shipping_address) || Address.new
  end

  def build_credit_cart
    self.credit_card ||= CreditCard.new
  end
end
