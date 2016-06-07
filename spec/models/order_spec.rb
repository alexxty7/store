require 'rails_helper'

RSpec.describe Order do
  let(:book) { create(:book) }
  let(:order) { create(:order) }

  context 'validations' do
    # it { is_expected.to validate_presence_of(:total) }
    # it { is_expected.to validate_presence_of(:completed_at) }
    it { is_expected.to validate_presence_of(:state) }
    # it { is_expected.to validate_inclusion_of(:state).in_array(Order::STATES) }
  end

  context 'associations' do
    it { is_expected.to belong_to(:user) }
    # it { is_expected.to belong_to(:credit_card) }
    # it { is_expected.to belong_to(:billing_address) }
    # it { is_expected.to belong_to(:shipping_address) }
    it { is_expected.to have_many(:order_items) }
  end

  context '#add' do
    describe 'book not in the order' do
      it 'creates a new order_items' do
        expect { order.add(book) }.to change(order.order_items, :count).by(1)
      end
    end

    describe 'book already added to order' do
      let!(:order_item) { create(:order_item, book: book, order: order) }

      it 'dont create new order_item' do
        expect { order.add(book) }.to_not change(order.order_items, :count)
      end

      it 'updates the quantity for order_item' do
        order.add(book)
        order_item.reload
        expect(order_item.quantity).to eq(2)
      end
    end
  end

  context '#calc_subtotal' do
    it 'returns total price for all order_items' do
      create_list(:order_item, 3, order: order)
      order.reload
      expect(order.send(:calc_subtotal)).to eq(4.5)
    end

    it 'returns 0 if order has no order_items' do
      expect(order.send(:calc_subtotal)).to eq(0)
    end
  end
end
