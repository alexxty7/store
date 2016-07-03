require 'rails_helper'

RSpec.describe OrderItem do
  it { is_expected.to delegate_method(:update_totals).to(:order) }

  context 'validations' do
    it { is_expected.to validate_presence_of(:price) }
    it { is_expected.to validate_presence_of(:quantity) }
  end

  context 'associations' do
    it { is_expected.to belong_to(:book) }
    it { is_expected.to belong_to(:order) }
  end

  describe '#subtotal' do
    it 'returns quantity * price' do
      order_item = create(:order_item, quantity: 2)
      expect(order_item.subtotal).to eq(3)
    end
  end
end
