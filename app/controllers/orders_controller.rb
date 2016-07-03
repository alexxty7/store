class OrdersController < ApplicationController
  before_action :authenticate_user!, only: [:show]
  before_action :set_order, only: [:edit, :update]

  def show
    @order = completed_orders.find(params[:id]).decorate
  end

  def edit
  end

  def add_item
    book = Book.find(params[:book_id])
    quantity = params[:order][:quantity].to_i
    current_order.add(book, quantity)
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
    current_order.clear
    redirect_to cart_path
  end

  private

  def set_order
    @order = current_order.decorate
  end

  def completed_orders
    current_user.orders.completed
  end

  def order_params
    params.require(:order)
          .permit(:coupon_code, order_items_attributes: [:id, :quantity])
  end
end
