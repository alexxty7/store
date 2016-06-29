class Address < ApplicationRecord
  belongs_to :country

  validates :firstname, :lastname, :address,
            :zipcode, :city, :phone, :country, presence: true
end
