require 'rails_helper'

feature 'Users signs up' do
  let(:user) { FactoryGirl.create(:user) }

  scenario 'with valid email and password' do
    sign_in_with user.email, user.password

    expect(page).to have_content('Signed in successfully.')
    expect(page).to have_content('Sign Out')
  end

  scenario 'with incorrect email or password' do
    sign_in_with 'someinvalidemail', 'invalid_password'

    expect(page).to have_content('Invalid Email or password.')
    expect(page).to have_content('Sign in')
  end
end
