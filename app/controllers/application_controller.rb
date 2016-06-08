class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_order
  
  def find_categories
    @categories = Category.all
  end

  def current_order
    @current_order ||= set_current_order
  end

  private

  def set_current_order
    @current_order = find_by_session_or_user
    if @current_order.nil?
      @current_order = Order.create(user: current_user)
      session[:order_id] = @current_order.id
    elsif current_user && @current_order.user.nil?
      @current_order.user = current_user
      @current_order.save      
    end
    @current_order
  end

  def find_by_session_or_user
    if session[:order_id]
      Order.find_by(id: session[:order_id])
    elsif current_user
      current_user.orders.in_progress.first
    end
  end
end
