require 'rails_helper'

RSpec.describe List, type: :model do
  it "has a valid factory" do
    expect(FactoryGirl.create(:list)).to be_valid
  end
end
