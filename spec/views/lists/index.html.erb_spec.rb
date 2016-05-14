require 'rails_helper'

RSpec.describe "lists/index", type: :view do
  before(:each) do
    assign(:lists, [
      List.create!(
        :subject => "Subject",
        :public_access => false
      ),
      List.create!(
        :subject => "Subject",
        :public_access => false
      )
    ])
  end

  it "renders a list of lists" do
    render
    assert_select "tr>td", :text => "Subject".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
