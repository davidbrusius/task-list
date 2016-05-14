require 'rails_helper'

RSpec.describe List, type: :model do
  it "has a valid factory" do
    expect(FactoryGirl.create(:list)).to be_valid
  end

  it { should belong_to(:user) }
  it { should have_many(:tasks) }
  it { should validate_presence_of(:subject) }
end
