require 'rails_helper'

feature 'Users create multiple tasks' do
  let(:user) { FactoryGirl.create(:user) }
  given!(:list) { FactoryGirl.create(:list, user: user) }

  scenario 'after create a list add tasks via AJAX', js: true do
    sign_in_with user.email, user.password
    visit lists_path
    click_link list.subject
    for i in 0..4
      task_description = Faker::Lorem.words(2).join(' ')
      fill_in 'task_description', with: task_description
      click_button 'Create Task'

      expect(page).to have_content(task_description)
    end
  end
end
