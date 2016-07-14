require 'rails_helper'

feature 'Users delete a task' do
  let(:user) { FactoryGirl.create(:user) }
  given!(:list) { FactoryGirl.create(:list, user: user) }
  given!(:task) { FactoryGirl.create(:task, description: Faker::Lorem.words(5).join(' '),
                    list: list) }
  before do
    sign_in_with user.email, user.password
  end

  scenario 'from a list with tasks', js: true do
    visit lists_path
    click_link list.subject
    expect(page).to have_content(task.description)

    first(".task-#{task.id} a[data-title=Delete]").click
    page.driver.browser.switch_to.alert.accept

    expect(page).to_not have_content(task.description)
  end
end
