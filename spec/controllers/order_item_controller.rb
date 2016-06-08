require 'rails_helper'

RSpec.describe OrderItemsController do
  let!(:order_item) { create(:order_item) }

  describe 'DELETE #destroy' do
    it 'deletes order_item' do
      expect { 
        delete :destroy, params: { id: order_item.id }
      }.to change(OrderItem, :count).by(-1)
    end

    it 'redirect to cart_path' do
      delete :destroy,  params: { id: order_item.id }
      expect(response).to redirect_to(cart_path)
    end
  end
end
