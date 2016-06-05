class BooksController < ApplicationController
  before_action :find_categories

  def index
    @books = Book.page(params[:page])
  end
end
