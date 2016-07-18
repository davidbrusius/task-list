require 'rails_helper'

feature 'Users access page with favorited lists' do
  given!(:user) { FactoryGirl.create(:user) }
  given!(:first_list) { FactoryGirl.create(:list, public_access: true) }
  given!(:second_list) { FactoryGirl.create(:list, public_access: true) }

  scenario 'favorited lists are listed' do
    sign_in_with user.email, user.password
    first_list.favorite_lists.create(user: user)
    second_list.favorite_lists.create(user: user)

    visit scoped_lists_path(list_scope: 'favorited')

    expect(page).to have_content(first_list.subject)
    expect(page).to have_content(second_list.subject)
  end
end
