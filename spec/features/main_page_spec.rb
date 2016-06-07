require_relative 'features_helper'

feature 'Main page' do
  given!(:book) { create(:book_with_order, quantity: 2) }
  given!(:book2) { create(:book_with_order, title: 'Some book') }

  scenario 'user can see best sellers', js: true do
    visit(root_path)

    within('.carousel') do
      expect(page).to have_content(book.title)
      expect(page).to have_content(book.price)
      expect(page).to have_content(book.description)
      expect(page).to have_content(book.author.full_name)
    end
  end

  scenario 'user can navigate between carousel items', js: true do
    visit(root_path)

    within('.carousel') do
      find('.right.carousel-control').click

      expect(page).to have_content(book2.title)
      expect(page).to_not have_content(book.title)
    end
  end
end
