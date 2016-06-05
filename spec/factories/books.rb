FactoryGirl.define do
  factory :book do
    title FFaker::Product.product_name
    description FFaker::Lorem.paragraph
    price 1.5
    in_stock 10
    author

    factory :book_with_order do
      transient do
        quantity 1
      end

      after(:create) do |book, evaluator|
        create(:order_item, book: book, quantity: evaluator.quantity)
      end
    end
  end
end
