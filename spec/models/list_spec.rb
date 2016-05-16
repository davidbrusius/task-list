require 'rails_helper'

RSpec.describe List, type: :model do
  context 'relations' do
    it { should belong_to(:user) }
    it { should have_many(:tasks) }
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
    end
  end
end
