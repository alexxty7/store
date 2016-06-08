FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "example#{n}@test.com" }
    password '12345678'
    password_confirmation '12345678'
    provider nil
    uid nil
  end
end
