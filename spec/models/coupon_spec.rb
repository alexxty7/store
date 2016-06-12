require 'rails_helper'

RSpec.describe Coupon do
  context 'associations' do
    it { is_expected.to have_many(:orders) }
  end

  describe '#expired?' do
    it 'check if coupon expired' do
      coupon = create('coupon', expires_at: Date.yesterday)
      expect(coupon).to be_expired
    end
  end
end
