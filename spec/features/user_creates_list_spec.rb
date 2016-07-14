require 'rails_helper'

feature 'Users create a list' do
  let(:user) { FactoryGirl.create(:user) }
  before do
    sign_in_with user.email, user.password
  end

  scenario 'with valid input' do
    visit lists_path
    click_link 'New List'
    fill_in 'list_subject', with: Faker::Lorem.words(2).join(' ')
    find('#list_public_access').set('true')
    click_button 'Create List'

    expect(page).to have_content('List was successfully created. You can now add tasks to this list.')
  end

  scenario 'with invalid input' do
    visit lists_path
    click_link 'New List'
    fill_in 'list_subject', with: ''
    click_button 'Create List'

    expect(page).to have_content("Subjectcan't be blank")
  end
end
