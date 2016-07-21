require 'rails_helper'

feature 'Users delete a task' do
  let(:user) { FactoryGirl.create(:user) }
  given!(:list) { FactoryGirl.create(:list, user: user) }
  given!(:task) { FactoryGirl.create(:task, list: list) }

  scenario 'from a list with tasks', js: true do
    sign_in_with user.email, user.password
    visit lists_path
    click_link list.subject

    expect(page).to have_content(task.description)
    find("a[data-title='Delete Task']").click

    expect(page).not_to have_content(task.description)
  end
end
