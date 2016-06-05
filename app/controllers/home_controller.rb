class HomeController < ApplicationController
  def index
    @best_sellers = Book.best_sellers.limit(5)
  end
end
