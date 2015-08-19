require 'rails_helper'

feature 'Sign in' do
  given(:user) { Fabricate :user }

  background { visit new_user_session_path }

  scenario 'Signing in with correct credentials' do
    submit_credentials(user.email, user.password)

    expect(page).to have_content 'Signed in successfully'
    expect(page.current_path).to eq root_path
  end

  scenario 'Signing in with incorrect credentials' do
    submit_credentials(user.email, 'wrong_password')

    expect(page).to have_content 'Invalid email or password.'
    expect(page.current_path).to eq new_user_session_path
  end
end

feature 'Sign out' do
  given(:user) { Fabricate :user }

  background { login_as(user, :scope => :user) }

  scenario 'User can successfully sign out and is redirected to login page' do
    visit root_path
    click_link 'Sign out'

    expect(page.current_path).to eq new_user_session_path
  end
end

def submit_credentials(email, password)
  within('#new_user') do
    fill_in 'Email', with: email
    fill_in 'Password', with: password
  end
  click_button 'Sign in'
end
