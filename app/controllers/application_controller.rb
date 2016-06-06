class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def current_order
  end
  
  protected

  def find_categories
    @categories = Category.all
  end
end
