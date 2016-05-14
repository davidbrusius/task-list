require 'rails_helper'

RSpec.describe Task, type: :model do
  it "has a valid factory" do
    expect(FactoryGirl.create(:task)).to be_valid
  end

  it { should validate_presence_of(:description) }
end
