require 'rails_helper'

feature 'Users toggle task done state' do
  given!(:user) { FactoryGirl.create(:user) }
  before do
    sign_in_with user.email, user.password
  end

  scenario 'mark task as done', js: true do
    task = FactoryGirl.create(:task, user: user)
    visit lists_path
    click_link task.list.subject
    expect(page).to have_content(task.description)
    expect(page).to have_selector :css, 'i.glyphicon-unchecked'
    first(".task-#{task.id} a.task-toggle-done").click
    expect(page).to have_selector :css, 'i.glyphicon-check'
  end

  scenario 'mark task as undone', js: true do
    task = FactoryGirl.create(:task, user: user, done: true)
    visit lists_path
    click_link task.list.subject
    expect(page).to have_content(task.description)
    expect(page).to have_selector :css, 'i.glyphicon-check'
    first(".task-#{task.id} a.task-toggle-done").click
    expect(page).to have_selector :css, 'i.glyphicon-unchecked'
  end

end
