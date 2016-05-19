require 'rails_helper'

RSpec.describe Task, type: :model do
  context 'relations' do
    it { should belong_to(:list) }
    it { should have_one(:user) }
  end

  context 'validations' do
    it { should validate_presence_of(:list) }
    it { should validate_presence_of(:description) }
  end

  it 'has a valid factory' do
    expect(FactoryGirl.create(:task)).to be_valid
  end
end
