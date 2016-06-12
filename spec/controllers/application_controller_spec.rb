require 'rails_helper'

RSpec.describe ApplicationController do
  describe '#current_order' do
    context 'current_user exists' do
      let(:user) { create(:user) }

      before do
        allow(controller).to receive(:current_user) { user }
      end

      context 'user has incomplete orders' do
        it 'returns first order in progress' do
          order = create(:order, user: user)
          expect(controller.current_order).to eq(order)
        end
      end

      context 'user dont has incomplete orders' do
        let!(:order) { controller.current_order }

        it 'creates new order associated with user' do
          expect(order.user).to eq(user)
        end

        it 'saves order_id in session' do
          expect(session[:order_id]).to eq(order.id)
        end
      end

      context 'there is order without user' do
        let(:order) { create(:order) }

        it 'associates order with user' do
          session[:order_id] = order.id
          order = controller.current_order
          expect(order.user).to eq(user)
        end
      end
    end

    context 'current_user do not exists' do
      let!(:order) { controller.current_order }

      it 'creates new order' do
        expect(order).to be_kind_of(Order)
      end

      it 'saves order_id in session' do
        expect(session[:order_id]).to eq(order.id)
      end
    end
  end
end
