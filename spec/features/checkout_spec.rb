require_relative 'features_helper'

feature 'Checkout' do
  given(:book) { create(:book) }
  given!(:country) { create(:country) }
  given!(:ship_method) { create(:shipment) }
  given(:address) { create(:address, country: country) }

  context 'address step' do
    scenario 'user can fill billing and shipping address' do
      add_book_to_cart(book)

      click_on('Checkout')
      fill_in_address_for('billing')

      click_on('Save and continue')

      expect(page).to have_content('Shipping methods')
      expect(page).to have_current_path(checkout_path(:delivery))
    end
  end

  context 'delivery step' do
    scenario 'user can choose shipping method' do
      add_book_to_cart(book)

      click_on('Checkout')
      fill_in_address_for('billing')
      click_on('Save and continue')

      choose('checkout_form[shipment_id]')
      click_on('Save and continue')

      expect(page).to have_content('Credit Card')
      expect(page).to have_current_path(checkout_path(:payment))
    end      
  end

  context 'payment step' do
    scenario 'user can fill credit card details' do
      add_book_to_cart(book)

      click_on('Checkout')
      fill_in_address_for('billing')
      click_on('Save and continue')

      choose('checkout_form[shipment_id]')
      click_on('Save and continue')

      fill_in_credit_card
      click_on('Save and continue')

      expect(page).to have_current_path(checkout_path(:confirm))
    end
  end

  context 'confirm step' do
    scenario 'user can place order' do
      add_book_to_cart(book)

      click_on('Checkout')
      fill_in_address_for('billing')
      click_on('Save and continue')

      choose('checkout_form[shipment_id]')
      click_on('Save and continue')

      fill_in_credit_card
      click_on('Save and continue')

      click_on('Place Order')

      expect(page).to have_current_path(checkout_path(:complete))
    end
  end


  context 'complete step' do
    scenario 'user can see order details' do
      add_book_to_cart(book)

      click_on('Checkout')
      fill_in_address_for('billing')
      click_on('Save and continue')

      choose('checkout_form[shipment_id]')
      click_on('Save and continue')

      fill_in_credit_card
      click_on('Save and continue')

      click_on('Place Order')

      expect(page).to have_content('Shipping Address')
      expect(page).to have_content('Billing Address')
      expect(page).to have_content('Shipments')
      expect(page).to have_content('Payment Information')
    end
  end
end
