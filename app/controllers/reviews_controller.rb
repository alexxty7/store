class ReviewsController < ApplicationController
  before_action :set_book
  before_action :authenticate_user!

  def new
    @review = @book.reviews.new
  end

  def create
    @review = @book.reviews.new(review_params.merge(user: current_user))
    if @review.save
      redirect_to @book, notice: t('review.flashes.created')
    else
      render :new
    end
  end

  private

  def review_params
    params.require(:review).permit(:body, :rating)
  end

  def set_book
    @book = Book.find(params[:book_id])
  end
end
