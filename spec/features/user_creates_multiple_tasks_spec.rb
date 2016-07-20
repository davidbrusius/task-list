require 'rails_helper'

feature 'Users create multiple tasks' do
  let(:user) { FactoryGirl.create(:user) }
  given!(:list) { FactoryGirl.create(:list, user: user) }

  scenario 'after create a list add tasks via AJAX', js: true do
    sign_in_with user.email, user.password
    visit lists_path
    click_link list.subject

    fill_in 'Description', with: 'Book Flight'
    click_button 'Create Task'
    fill_in 'Description', with: 'Packing'
    click_button 'Create Task'

    expect(page).to have_content('Book Flight')
    expect(page).to have_content('Packing')
  end
end
