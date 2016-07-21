require 'rails_helper'

feature 'Users favorite and unfavorite a list' do
  given!(:user) { FactoryGirl.create(:user) }
  given!(:list) { FactoryGirl.create(:public_list) }
  before do
    sign_in_with user.email, user.password
  end

  scenario 'favorite when a list is not favorited by the user', js: true do
    visit scoped_lists_path(list_scope: 'public')

    find("a[data-title='Favorite List']").click

    expect(page).to have_selector(:icon, 'star')
    expect(page).to have_link('', href: list_unfavorite_path(list_id: list.id))
  end

  scenario 'unfavorite when a list is favorited by the user', js: true do
    list.favorite_lists.create(user: user)
    visit scoped_lists_path(list_scope: 'public')

    find("a[data-title='Unfavorite List']").click

    expect(page).to have_selector(:icon, 'star')
    expect(page).to have_link('', href: list_favorite_path(list_id: list.id))
  end
end
