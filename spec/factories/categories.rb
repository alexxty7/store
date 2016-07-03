FactoryGirl.define do
  factory :category do
    sequence(:name) { |n| "Book category #{n}" }
  end
end
