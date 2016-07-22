require 'rails_helper'

RSpec.describe List, type: :model do
  context 'validations' do
    it { should validate_presence_of(:user) }
    it { should validate_presence_of(:subject) }
  end

  it 'has a valid factory' do
    expect(build(:list)).to be_valid
  end

  describe '.publicly_accessible' do
    it 'return only public lists' do
      user = create(:user)
      private_list = create(:list, user: user)
      public_list = create(:public_list, user: user)
      other_public_list = create(:public_list, user: user)

      expect(List.publicly_accessible).not_to include(private_list)
      expect(List.publicly_accessible).to include(public_list, other_public_list)
    end
  end

  describe '#owned_by?' do
    let(:user) { create(:user) }

    context 'user is the owner of the list' do
      it 'return true' do
        list = create(:list, user: user)

        expect(list).to be_owned_by(user)
      end
    end

    context 'user is not the owner of the list' do
      it 'return false' do
        other_user = create(:user)

        list = create(:list, user: other_user)

        expect(list).not_to be_owned_by(user)
      end
    end
  end

  describe '#favorited_by?' do
    let(:user) { create(:user) }

    context 'user favorited the list' do
      it 'return true' do
        list = create(:public_list, user: user)

        create(:favorite_list, user: user, list: list)

        expect(list).to be_favorited_by(user)
      end
    end

    context 'user does not favorited the list' do
      it 'return false' do
        other_user = create(:user)
        list = create(:public_list, user: user)

        create(:favorite_list, user: other_user, list: list)

        expect(list).not_to be_favorited_by(user)
      end
    end
  end

  describe '.destroy_favorite_lists' do
    context 'list public_access changed from true to false' do
      it 'destroy all favorite lists of the changed list' do
        list = create(:public_list)
        create_list(:favorite_list, 2, list: list)

        expect {
          list.update!(public_access: false)
        }.to change { list.favorite_lists.count }.from(2).to(0)
      end
    end
  end
end
