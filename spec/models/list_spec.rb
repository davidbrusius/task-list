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
    expect(FactoryGirl.build(:list)).to be_valid
  end

  describe '.publicly_accessible' do
    it 'return only public lists' do
      user = FactoryGirl.create(:user)
      private_list = FactoryGirl.create(:list, user: user)
      public_list = FactoryGirl.create(:public_list, user: user)
      other_public_list = FactoryGirl.create(:public_list, user: user)

      expect(List.publicly_accessible).not_to include(private_list)
      expect(List.publicly_accessible).to include(public_list, other_public_list)
    end
  end

  describe '#owned_by?' do
    let(:user) { FactoryGirl.create(:user) }

    context 'user is the owner of the list' do
      it 'return true' do
        list = FactoryGirl.create(:list, user: user)

        expect(list).to be_owned_by(user)
      end
    end

    context 'user is not the owner of the list' do
      it 'return false' do
        other_user = FactoryGirl.create(:user)

        list = FactoryGirl.create(:list, user: other_user)

        expect(list).not_to be_owned_by(user)
      end
    end
  end

  describe '#favorited_by?' do
    let(:user) { FactoryGirl.create(:user) }

    context 'user favorited the list' do
      it 'return true' do
        list = FactoryGirl.create(:public_list, user: user)

        FactoryGirl.create(:favorite_list, user: user, list: list)

        expect(list).to be_favorited_by(user)
      end
    end

    context 'user does not favorited the list' do
      it 'return false' do
        other_user = FactoryGirl.create(:user)
        list = FactoryGirl.create(:public_list, user: user)

        FactoryGirl.create(:favorite_list, user: other_user, list: list)

        expect(list).not_to be_favorited_by(user)
      end
    end
  end

  describe '.destroy_favorite_lists' do
    context 'list public_access changed from true to false' do
      it 'destroy all favorite lists of the changed list' do
        list = FactoryGirl.create(:public_list)
        FactoryGirl.create_list(:favorite_list, 2, list: list)

        expect {
          list.update!(public_access: false)
        }.to change { list.favorite_lists.count }.from(2).to(0)
      end
    end
  end
end
