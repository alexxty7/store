class OrdersController < ApplicationController
  before_action :set_order

  def show
    @order = Order.find(params[:id])
  end

  def edit
  end

  def add_item
    book = Book.find(params[:book_id])
    quantity = params[:order][:quantity].to_i
    @order.add(book, quantity)
    redirect_to cart_path
  end

  def update
    if @order.update(order_params)
      if params.key?(:checkout)
        redirect_to checkout_index_path
      else
        redirect_to cart_path
      end
    else
      render(:edit)
    end
  end

  def empty
    @order.clear
    redirect_to cart_path
  end

  private

  def order_params
    params.require(:order)
          .permit(:coupon_code, order_items_attributes: [:id, :quantity])
  end

  def set_order
    @order ||= current_order
  end
end
