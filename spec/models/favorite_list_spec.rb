require 'rails_helper'

RSpec.describe FavoriteList, type: :model do
  context 'validations' do
    it { should validate_presence_of(:user) }
    it { should validate_presence_of(:list) }
    it do
      create(:favorite_list)
      should validate_uniqueness_of(:user).scoped_to(:list_id)
    end
  end

  it 'has a valid factory' do
    expect(create(:favorite_list)).to be_valid
  end

  context 'favorite a not publicly accessible list' do
   it 'prevent favorite list creation' do
     user = create(:user)
     list = create(:list)

     favorite_list = list.favorite_lists.create(user: user)

     expect(favorite_list).not_to be_persisted
     expect(favorite_list.errors[:list]).to include('is not publicly accessible')
    end
  end

  context 'favorite a publicly accessible list' do
   it 'create favorite list' do
     user = create(:user)
     list = create(:public_list)

     favorite_list = list.favorite_lists.create(user: user)

     expect(favorite_list).to be_persisted
     expect(list).to be_favorited_by(user)
    end
  end
end
