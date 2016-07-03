FactoryGirl.define do
  factory :address, aliases: [:billing_address, :shipping_address] do
    address FFaker::Address.street_address
    zipcode FFaker::AddressUS.zip_code
    city FFaker::Address.city
    phone FFaker::PhoneNumber.phone_number
    country
    firstname FFaker::Name.first_name
    lastname FFaker::Name.last_name
  end
end
