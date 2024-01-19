require 'rails_helper'

RSpec.feature 'User Authentication', type: :feature do
  scenario 'User logs in successfully' do
    # Create a user
    user = User.create(name: 'Peter', email: 'peter@example.com', password: 'password')

    # Visit the login page
    visit new_user_session_path

    # Fill in the login form
    fill_in 'Email', with: 'peter@example.com'
    fill_in 'Password', with: 'password'

    # Click the login button
    click_button 'Log in'

    # Assert that the user is redirected to the home page
    expect(page).to have_current_path(authenticated_root_path)

    # Assert that the user is logged in
    expect(page).to have_content('Groups')
  end
end

