require_relative 'features_helper'

feature 'Book' do
  given!(:book) { create(:book) }

  scenario 'user can view detailed information about a book on a book page' do
    visit(book_path(book))

    expect(page).to have_content(book.title)
    expect(page).to have_content(book.price)
    expect(page).to have_content(book.description)
  end

  scenario 'user can put books into a shopping cart' do
    visit(book_path(book))

    click_on('Add to cart')

    expect(page).to have_current_path(cart_path)
    expect(page).to have_content(book.title)
    expect(page).to have_content(book.price)
  end
end
