require 'rails_helper'

RSpec.describe List, type: :model do
  context 'relations' do
    it { should belong_to(:user) }
    it { should have_many(:tasks) }
    it { should have_many(:favorite_lists) }
    it { should have_many(:favorited_by) }
  end
  context 'validations' do
    it { should validate_presence_of(:user) }
    it { should validate_presence_of(:subject) }
  end

  it 'has a valid factory' do
    expect(FactoryGirl.create(:list)).to be_valid
  end

  describe '.publicly_accessible' do
    it 'return only public lists' do
      user = FactoryGirl.create(:user)
      2.times { FactoryGirl.create(:list, user: user) }
      3.times { FactoryGirl.create(:list, user: user, public_access: true) }

      expect(List.publicly_accessible.count).to be(3)
      expect(List.publicly_accessible.pluck(:public_access)).to match_array([true, true, true])
    end
  end

  describe '#owned_by?' do
    let!(:user) { FactoryGirl.create(:user) }

    context 'user is the owner of the list' do
      it 'return true' do
        list = FactoryGirl.create(:list, user: user)

        expect(list.owned_by?(user)).to be true
      end
    end

    context 'user is not the owner of the list' do
      it 'return false' do
        other_user = FactoryGirl.create(:user)
        list = FactoryGirl.create(:list, user: other_user)

        expect(list.owned_by?(user)).to be false
      end
    end
  end

  describe '#favorited_by?' do
    let!(:user) { FactoryGirl.create(:user) }

    context 'user favorited the list' do
      it 'return true' do
        list = FactoryGirl.create(:list, user: user, public_access: true)
        FactoryGirl.create(:favorite_list, user: user, list: list)

        expect(list.favorited_by?(user)).to be true
      end
    end

    context 'user does not favorited the list' do
      it 'return false' do
        other_user = FactoryGirl.create(:user)
        list = FactoryGirl.create(:list, user: user, public_access: true)
        FactoryGirl.create(:favorite_list, user: other_user, list: list)

        expect(list.favorited_by?(user)).to be false
      end
    end
  end

  describe '.destroy_favorite_lists' do
    context 'list public_access changed from true to false' do
      it 'destroy all favorite lists of the changed list' do
        list = FactoryGirl.create(:list, public_access: true)
        2.times { FactoryGirl.create(:favorite_list, list: list) }
        expect(list.favorite_lists.count).to be(2)
        list.public_access = false
        list.save!
        expect(list.favorite_lists.count).to be(0)
      end
    end
  end
end
