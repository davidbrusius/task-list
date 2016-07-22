require 'rails_helper'

feature 'Users toggle task done state' do
  let(:user) { create(:user) }
  before do
    sign_in_with user.email, user.password
  end

  scenario 'mark task as done', js: true do
    task = create(:task, user: user)
    visit lists_path

    click_link task.list.subject
    expect(page).to have_content(task.description)
    expect(page).to have_selector(:icon, 'unchecked')

    first(".task-#{task.id} a.task-toggle-done").click
    expect(page).to have_selector(:icon, 'check')
  end

  scenario 'mark task as not done', js: true do
    task = create(:task_done, user: user)
    visit lists_path

    click_link task.list.subject
    expect(page).to have_content(task.description)
    expect(page).to have_selector(:icon, 'check')

    first(".task-#{task.id} a.task-toggle-done").click
    expect(page).to have_selector(:icon, 'unchecked')
  end
end
