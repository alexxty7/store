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
    country = create(:country)
    address = "order_#{address_type}_address_attributes"
    fill_in "#{address}_firstname", with: FFaker::Name.first_name
    fill_in "#{address}_lastname", with: FFaker::Name.last_name
    fill_in "#{address}_address", with: FFaker::Address.street_address
    fill_in "#{address}_city", with: FFaker::Address.city
    fill_in "#{address}_zipcode", with: FFaker::Address.zip_code
    fill_in "#{address}_phone", with: FFaker::PhoneNumber.phone_number
    select country.name, from: "#{address}_country"
  end
end
