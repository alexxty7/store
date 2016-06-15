class Country < ApplicationRecord
  validates :name, presence: true
  validates :name, uniqueness: { case_sensitive: false }
end
