require 'rails_helper'

RSpec.describe FavoriteList, type: :model do
  context 'relations' do
    it { should belong_to(:user) }
    it { should belong_to(:list) }
  end
  context 'validations' do
    it { should validate_presence_of(:user) }
    it { should validate_presence_of(:list) }
  end

  it 'has a valid factory' do
    expect(FactoryGirl.create(:favorite_list)).to be_valid
  end
end
