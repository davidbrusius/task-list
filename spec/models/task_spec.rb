require 'rails_helper'

RSpec.describe Task, type: :model do
  context 'validations' do
    it { should validate_presence_of(:list) }
    it { should validate_presence_of(:description) }
  end

  it 'has a valid factory' do
    expect(FactoryGirl.create(:task)).to be_valid
  end
end
