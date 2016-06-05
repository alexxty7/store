require_relative 'features_helper'

feature 'Categories' do
  given!(:history) { create(:category, name: 'History') }
  given!(:fiction) { create(:category, name: 'Fiction') }
  given!(:book) { create(:book, category: history) }

  scenario 'user can see list of categoiries' do
    visit books_path

    expect(page).to have_css('a', text: 'History')
    expect(page).to have_css('a', text: 'Fiction')
  end

  scenario 'user can navigate by category' do
    visit books_path

    click_on('History')

    expect(page).to have_css('h1', text: 'History')
    expect(page).to have_content(book.title)
    expect(page).to have_content(book.price)
  end

  scenario 'user can see breadcrumb on category page' do

  end
end
