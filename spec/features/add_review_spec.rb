require_relative 'features_helper'

feature 'Add review' do
  given!(:book) { create(:book) }
  given(:user) { create(:user) }

  scenario 'authenticated user can add review' do
    sign_in(user)

    visit(book_path(book))

    click_on('Leave a Review')

    fill_in('review[rating]', with: '5')
    fill_in('Text review', with: 'Great book.')
    click_on('Add')

    expect(page).to have_content('Great book.')
    expect(page).to have_content(user.username)
  end

  scenario 'user try to create invalid review' do
    sign_in(user)

    visit(book_path(book))

    click_on('Leave a Review')

    fill_in('review[rating]', with: '5')
    fill_in('Text review', with: '')
    click_on('Add')

    expect(page).to_not have_content('Great book.')
    expect(page).to have_content("Body can't be blank")
  end

  scenario "non-authenticated user can't add review" do
    visit(book_path(book))

    click_on('Leave a Review')

    expect(page).to have_current_path(new_user_session_path)
    expect(page).to have_css('#flash_alert', text: "You need to sign in or sign up before continuing.")
  end
end
