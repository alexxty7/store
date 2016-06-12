class Coupon < ApplicationRecord
  has_many :orders

  def expired?
    Date.current < starts_at || Date.current > expires_at
  end
end
