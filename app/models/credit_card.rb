class CreditCard < ApplicationRecord
  validates :number, :cvv, :month, :year, presence: true, numericality: true
end
