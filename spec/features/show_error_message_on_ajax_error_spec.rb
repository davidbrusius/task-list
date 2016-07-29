require 'rails_helper'

feature 'Show error message on ajax errors' do

  scenario 'favorite an already favorited list', js: true do
    user = create(:user)
    sign_in_with user.email, user.password
    list = create(:public_list)

    visit scoped_lists_path(list_scope: 'public')
    create(:favorite_list, user: user, list: list)
    click_link 'Favorite List'

    expect(page).to have_content('We were unable to process your request')
  end
end
