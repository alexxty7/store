FactoryGirl.define do
  factory :order do
    number 'R856999'
    completed_at nil

    factory :order_with_coupon do
      coupon
    end
  end
end
