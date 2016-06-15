FactoryGirl.define do
  factory :shipment do
    name FFaker::Company.name
    price 5
    description nil
  end
end
