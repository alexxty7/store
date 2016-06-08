require_relative 'features_helper'

feature 'Cart' do
  given!(:book) { create(:book) }
  
  background do
    visit(book_path(book))
    click_on('Add to cart')
  end

  scenario 'user can remove an item from cart' do

    find('.delete').click

    expect(page).to have_content("Your cart is empty")
    expect(page).to_not have_content(book.title)
    expect(page).to_not have_content(book.price)
  end

  scenario 'user can update an item quantity' do
    within('.table.cart') do
      fill_in('order[order_items_attributes][0][quantity]', with: '2')
    end

    click_on('Update')

    expect(page.find('#order_order_items_attributes_0_quantity').value).to eq('2')
  end

  scenario 'user can empty cart' do
    click_on('Empty cart')

    expect(page).to have_content("Your cart is empty")
  end

  scenario 'user can apply valid coupon code'
  scenario 'user can not apply invalid coupon code'
end
