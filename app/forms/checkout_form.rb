class CheckoutForm
  include ActiveModel::Model

  attr_accessor \
    :order,
    :step,
    :use_billing,
    :shipment_id,
    :billing_address_attributes,
    :shipping_address_attributes,
    :credit_card_attributes

  validate :validate_children

  def persisted?
    false
  end

  def save
    assign_values
    return false unless valid?
    save_values
    order.save
    true
  end

  def billing_address
    order.billing_address ||= Address.new
  end

  def shipping_address
    order.shipping_address ||= Address.new
  end

  def credit_card
    order.credit_card ||= CreditCard.new
  end

  private

  def assign_values
    case step
    when :address then assign_address
    when :delivery then assign_delivery
    when :payment then assign_payment
    end
  end

  def save_values
    case step
    when :address
      shipping_address.save && billing_address.save
    when :payment
      credit_card.save
    end
  end

  def assign_address
    shipping_address.assign_attributes(shipping_address_attributes)
    billing_address.assign_attributes(billing_address_attributes)
    clone_billing_address if use_billing?
  end

  def assign_delivery
    order.shipment_id = shipment_id
  end

  def assign_payment
    credit_card.assign_attributes(credit_card_attributes)
  end

  def validate_children
    case step
    when :address
      promote_errors(billing_address.errors) if billing_address.invalid?
      promote_errors(shipping_address.errors) if shipping_address.invalid?
    when :payment
      promote_errors(credit_card.errors) if credit_card.invalid?
    end
  end

  def promote_errors(child_errors)
    child_errors.each do |attribute, message|
      errors.add(attribute, message)
    end
  end

  def use_billing?
    use_billing == '1'
  end

  def clone_billing_address
    if billing_address && shipping_address.nil?
      order.shipping_address = billing_address.clone
    else
      shipping_address.attributes = billing_address_attributes.except('id')
    end
  end
end
