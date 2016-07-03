class Review < ApplicationRecord
  belongs_to :book
  belongs_to :user

  validates :body, :rating, presence: true
  validates :rating, inclusion: { in: 1..5 }
end
