require 'rails_helper'

feature 'Users create a list' do
  before do
    sign_in
    visit lists_path
  end

  scenario 'with valid input' do
    click_link 'New List'
    fill_in 'Subject', with: 'My Travel List'
    check 'Public access'
    click_button 'Create List'

    expect(page).to have_content('List was successfully created')
  end

  scenario 'with invalid input' do
    click_link 'New List'
    fill_in 'Subject', with: ''
    click_button 'Create List'

    expect(page).to have_content("Subjectcan't be blank")
  end
end
