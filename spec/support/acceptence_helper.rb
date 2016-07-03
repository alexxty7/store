module AcceptenceHelper
  def sign_in(user)
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_on 'Log in'
  end

  def add_book_to_cart(book)
    visit(book_path(book))

    click_on('Add to cart')
  end

  def fill_in_address_for(address_type)
    address = "checkout_form_#{address_type}_address_attributes"
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
    select '12', from: 'checkout_form_credit_card_attributes_month'
    select '2020', from: 'checkout_form_credit_card_attributes_year'
    fill_in 'Card code', with: '1234'
  end
end
