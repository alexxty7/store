require_relative 'features_helper'

feature 'User sign in' do
  context 'with credentials' do
    given(:user) { create(:user)}

    scenario 'Registered user try to sign in' do
      sign_in(user)

      expect(page).to have_content('Signed in successfully')
      expect(page).to have_current_path(root_path)
    end

    scenario 'Non-registered user try to sign in' do
      visit(new_user_session_path)

      fill_in('Email', with: 'wrong@test.com')
      fill_in('Password', with: '12345678')
      click_on('Log in')

      expect(page).to have_content('Invalid Email or password')
      expect(page).to have_current_path(new_user_session_path)
    end

    scenario 'Authenticated user try logout' do
      sign_in(user)

      click_on('Sign out')

      expect(page).to have_content('Signed out successfully.')
    end
  end

  context 'with omniauth' do
    background do
      OmniAuth.config.test_mode = true
      visit(root_path)
    end

    scenario 'user can sign in via facebook' do
      mock_auth_hash

      click_on('Sign in')
      expect(page).to have_content('Sign in with Facebook')

      click_on('Sign in with Facebook')
      expect(page).to have_content('Successfully authenticated from Facebook account.')
    end

    scenario 'with invalid credentials' do
      OmniAuth.config.mock_auth[:facebook] = :invalid_credentials

      click_on('Sign in')
      click_on('Sign in with Facebook')

      expect(page).to have_content('Could not authenticate you from Facebook because "Invalid credentials"')
    end
  end
end
