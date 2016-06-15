FactoryGirl.define do
  factory :credit_card do
    number '1111111111111111'
    cvv '1234'
    month '11'
    year '2020'
    firstname FFaker::Name.first_name
    lastname FFaker::Name.last_name
  end
end
