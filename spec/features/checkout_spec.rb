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

      choose('order[shipment_id]')
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

      choose('order[shipment_id]')
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

      choose('order[shipment_id]')
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

      choose('order[shipment_id]')
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

  def fill_in_address_for(address_type)
    address = "order_#{address_type}_address_attributes"
    fill_in "#{address}_firstname", with: FFaker::Name.first_name
    fill_in "#{address}_lastname", with: FFaker::Name.last_name
    fill_in "#{address}_address", with: FFaker::Address.street_address
    fill_in "#{address}_city", with: FFaker::Address.city
    fill_in "#{address}_zipcode", with: FFaker::AddressUS.zip_code
    fill_in "#{address}_phone", with: FFaker::PhoneNumber.phone_number
    select country.name, from: "#{address}_country_id"
  end

  def fill_in_credit_card
    fill_in 'Card number', with: '1111111111111111'
    select '12', from: 'order_credit_card_attributes_month'
    select '2020', from: 'order_credit_card_attributes_year'
    fill_in 'Card code', with: '1234'
  end
end
