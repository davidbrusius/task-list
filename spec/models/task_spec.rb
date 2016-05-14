require 'rails_helper'

RSpec.describe Task, type: :model do
  it "has a valid factory" do
    expect(FactoryGirl.create(:task)).to be_valid
  end

  it { should belong_to(:list) }
  it { should have_one(:user) }
  it { should validate_presence_of(:list) }
  it { should validate_presence_of(:description) }
end
