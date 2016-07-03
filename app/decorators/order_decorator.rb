class OrderDecorator < Drape::Decorator
  delegate_all
  delegate :last_numbers, :expiration_date, to: :credit_card, prefix: true

  decorates_association :credit_card
  decorates_association :shipping_address
  decorates_association :billing_address
  decorates_association :order_items

  def completed_at
    h.time_tag(object.completed_at.to_date)
  end
end
