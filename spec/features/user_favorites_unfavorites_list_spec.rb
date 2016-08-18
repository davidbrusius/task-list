require 'rails_helper'

feature 'Users favorite and unfavorite a list' do

  scenario 'favorite when a list is not favorited by the user', js: true do
    sign_in
    list = create(:public_list)

    visit scoped_lists_path(list_scope: 'public')
    click_link 'Favorite List'

    expect(page).to have_selector(:icon, 'star')
    expect(page).to have_link('', href: list_unfavorite_path(list_id: list.id))
  end

  scenario 'unfavorite when a list is favorited by the user', js: true do
    user = create(:user)
    sign_in_with user.email, user.password
    favorite_list = create(:favorite_list, user: user, list: create(:public_list))

    visit scoped_lists_path(list_scope: 'public')
    click_link 'Unfavorite List'

    expect(page).to have_selector(:icon, 'star')
    expect(page).to have_link('', href: list_favorite_path(list_id: favorite_list.list_id))
  end
end
