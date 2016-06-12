require_relative 'features_helper'

feature 'Sign up' do
  scenario 'User try to sign up' do
    visit(root_path)

    click_on('Sign up')

    within('#new_user') do
      fill_in('Email', with: 'test_user@test.com')
      fill_in('Password', with: '12345678')
      fill_in('Password confirmation', with: '12345678')

      click_on('Sign up')
    end

    expect(page).to have_content('You have signed up successfully.')
  end
end
