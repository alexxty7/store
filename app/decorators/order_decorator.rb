class OrderDecorator < Drape::Decorator
  delegate_all
  decorates_association :credit_card
  decorates_association :shipping_address
  decorates_association :billing_address
end
