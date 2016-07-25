require 'rails_helper'

feature 'Users delete a task' do

  scenario 'from a list with tasks', js: true do
    user = create(:user)
    sign_in_with user.email, user.password
    list = create(:list, user: user, subject: 'A List with one task')
    create(:task, list: list, description: 'A task to be deleted')
    visit lists_path

    click_link 'A List with one task'
    expect(page).to have_content('A task to be deleted')
    find("a[data-title='Delete Task']").click

    expect(page).not_to have_content('A task to be deleted')
  end
end
