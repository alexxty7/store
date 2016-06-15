class CreditCard < ApplicationRecord
  validates :number, :cvv, :month, :year, presence: true
end
