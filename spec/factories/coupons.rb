FactoryGirl.define do
  factory :coupon do
    code 'QWERTY'
    expires_at Date.new(2017, 06, 11)
    starts_at Date.new(2015, 06, 11)
    discount 5
  end
end
