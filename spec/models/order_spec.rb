require 'rails_helper'

RSpec.describe Order do
  let(:book) { create(:book) }
  let(:order) { create(:order) }

  context 'validations' do
    it { is_expected.to validate_presence_of(:state) }
  end

  context 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:coupon) }
    it { is_expected.to belong_to(:credit_card) }
    it { is_expected.to belong_to(:billing_address) }
    it { is_expected.to belong_to(:shipping_address) }
    it { is_expected.to belong_to(:shipment) }
    it { is_expected.to have_many(:order_items) }
  end

  describe '#add' do
    context 'book not in the order' do
      it 'creates a new order_items' do
        expect { order.add(book) }.to change(order.order_items, :count).by(1)
      end
    end

    context 'book already added to order' do
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

  describe '#set_coupon' do
    let(:order) { build(:order, coupon_code: 'QWERTY') }

    context 'valid coupon code' do
      it 'assigns coupon to order' do
        coupon = create(:coupon, code: 'QWERTY')
        order.set_coupon
        expect(order.coupon).to eq(coupon)
      end
    end

    context 'invalid coupon code' do
      before { order.set_coupon }

      it 'not assigns coupon to order' do
        expect(order.coupon).to be_nil
      end

      it 'add errors to base' do
        expect(order.errors[:base][0]).to eq('Invalid coupon code')
      end
    end
  end

  describe '#update_totals' do
    it 'calculate and updates order subtotal' do
      create_list(:order_item, 3, price: 10, order: order)
      order.update_totals
      expect(order.subtotal).to eq(30)
    end

    it 'calculate and updates order total' do
      order = create(:order_with_coupon)
      create_list(:order_item, 3, price: 10, order: order)
      order.update_totals
      expect(order.total).to eq(25)
    end
  end
end
