class BooksController < ApplicationController
  def index
    @categories = Category.all
    @books = Book.all
  end
end
