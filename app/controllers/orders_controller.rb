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
end