class OrderItemsController < ApplicationController
  def destroy
    item = OrderItem.find(params[:id])
    item.destroy
    redirect_to cart_path
  end
end
