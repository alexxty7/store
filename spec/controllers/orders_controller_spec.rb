require 'rails_helper'

RSpec.describe OrdersController do
  let(:order) { build_stubbed(:order) }

  describe 'GET #edit' do
    before do
      allow(controller).to receive_messages(current_order: order)
      get :edit
    end

    it 'assigns @order' do
      expect(assigns(:order)).to eq(order)
    end

    it 'render :edit template' do
      expect(response).to render_template(:edit)
    end
  end

  describe 'POST #add_item' do
    let!(:book) { create(:book) }

    before do
      allow(controller).to receive_messages(current_order: order)
      allow(order).to receive(:add)
      post :add_item, params: { book_id: book.id, order: {quantity: 1} }
    end

    it 'receives add_item' do
      expect(order).to have_received(:add).with(book, 1)
    end

    it 'redirects to shopping cart' do
      expect(response).to redirect_to(cart_path)
    end
  end
end
