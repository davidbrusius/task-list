require 'rails_helper'

feature 'Users create multiple tasks' do

  scenario 'after create a list add tasks via AJAX', js: true do
    user = create(:user)
    sign_in_with user.email, user.password
    create(:list, user: user, subject: 'My Travel List' )
    visit lists_path

    click_link 'My Travel List'
    fill_in 'Description', with: 'Book Flight'
    click_button 'Create Task'
    fill_in 'Description', with: 'Packing'
    click_button 'Create Task'

    expect(page).to have_content('Book Flight')
    expect(page).to have_content('Packing')
  end
end
