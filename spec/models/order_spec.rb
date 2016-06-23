require 'rails_helper'

RSpec.describe Order do
  let(:book) { create(:book) }
  let(:order) { create(:order) }

  it { is_expected.to delegate_method(:clear).to(:order_items) }
  it { is_expected.to delegate_method(:empty?).to(:order_items) }

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

  describe '#set_completed_time' do
    it 'updates completed_at time' do
      order.set_completed_time
      expect(order.completed_at).not_to be_nil
    end

    it 'calls after change order state to in_queue' do
      expect(order).to receive(:set_completed_time)
      order.place_order
    end
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

      it 'calls before validations if coupon_code present' do
        expect(order).to receive(:set_coupon)
        order.valid?
      end

      it 'doens not calls before validations if coupon_code absent' do
        order = build(:order)
        expect(order).to_not receive(:set_coupon)
        order.valid?
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
      create_list(:order_item, 3, price: 10, order: order)
      order.update_totals
      expect(order.total).to eq(30)
    end

    it 'calculate and updates order shipment_total' do
      shipment = create(:shipment, price: 5)
      order = create(:order, shipment: shipment)
      order.update_totals
      expect(order.shipment_total).to eq(5)
    end
  end

  describe '#set_number' do
    it 'sets order number' do
      order = create(:order)
      expect(order.number).not_to be_nil
    end
  end
end
