class OrdersController < ApplicationController
  def edit
    @order = current_order
  end

  def add_item
    book = Book.find(params[:book_id])
    quantity = params[:order][:quantity].to_i
    current_order.add(book, quantity)
    redirect_to cart_path
  end

  def update
    @order = current_order
    if @order.update_attributes(order_params)
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

  def order_params
    params.require(:order)
          .permit(order_items_attributes: [:id, :quantity])
  end
end
