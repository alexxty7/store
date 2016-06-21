require 'rails_helper'

RSpec.describe OrdersController do
  let(:order) { build_stubbed(:order) }

  describe 'GET #show' do
    before do
      allow(Order).to receive(:find).and_return(order)
      get :show, params: { id: order.id }
    end
 
    it "receives find and return post" do
      expect(Order).to have_received(:find).with(order.id.to_s)
    end
 
    it "assigns @post" do
      expect(assigns(:order)).not_to be_nil
    end
 
    it "renders :show template" do
      expect(response).to render_template(:show)
    end
  end

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
      allow(controller).to receive(:current_order) { order }
      allow(order).to receive(:add)
      post :add_item, params: { book_id: book.id, order: { quantity: 1 } }
    end

    it 'receives add_item' do
      expect(order).to have_received(:add).with(book, 1)
    end

    it 'redirects to shopping cart' do
      expect(response).to redirect_to(cart_path)
    end
  end

  describe 'PATCH #update' do
    let(:order_params) { attributes_for(:order) }

    before do
      allow(controller).to receive(:current_order) { order }
      allow(order).to receive(:update).and_return true
    end

    context 'with valid attributes' do
      it 'assigns @order' do
        put :update, params: { id: order.id, order: order_params }
        expect(assigns(:order)).not_to be_nil
      end

      it 'receives update for @order' do
        expect(order).to receive(:update)
        put :update, params: { id: order.id, order: order_params }
      end

      it 'redirects to cart page' do
        put :update, params: { id: order.id, order: order_params }
        expect(response).to redirect_to(cart_path)
      end

      it 'redirects to checkout_index_path if params has key :checkout' do
        put :update, params: { id: order.id, order: order_params, checkout: true }
        expect(response).to redirect_to(checkout_index_path)
      end
    end

    context 'with invalid attributes' do
      it 'renders :edit template' do
        allow(order).to receive(:update).and_return false
        put :update, params: { id: order.id, order: order_params }
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'PATCH #empty' do
    before do
      allow(controller).to receive(:current_order) { order }
    end

    it 'receives clear for @order' do
      expect(order).to receive(:clear)
      put :empty
    end

    it 'redirects to cart page' do
      put :empty
      expect(response).to redirect_to(cart_path)
    end
  end
end
