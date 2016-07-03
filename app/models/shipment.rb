class Shipment < ApplicationRecord
  validates :name, :price, presence: true
end
