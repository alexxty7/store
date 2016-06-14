FactoryGirl.define do
  factory :review do
    body FFaker::Lorem.paragraph
    rating 5
    approved false
    book

    factory :invalid_review do
      body ''
    end
  end
end
