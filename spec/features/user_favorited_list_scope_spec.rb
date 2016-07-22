require 'rails_helper'

feature 'Users access page with favorited lists' do

  scenario 'favorited lists are listed' do
    user = create(:user)
    sign_in_with user.email, user.password
    create(:favorite_list, user: user, list: create(:public_list, subject: 'Holiday List'))
    create(:favorite_list, user: user, list: create(:public_list, subject: 'Books List'))

    visit scoped_lists_path(list_scope: 'favorited')

    expect(page).to have_content('Holiday List')
    expect(page).to have_content('Books List')
  end
end
