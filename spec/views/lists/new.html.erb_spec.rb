require 'rails_helper'

RSpec.describe "lists/new", type: :view do
  before(:each) do
    assign(:list, List.new(
      :subject => "MyString",
      :public_access => false
    ))
  end

  it "renders new list form" do
    render

    assert_select "form[action=?][method=?]", lists_path, "post" do

      assert_select "input#list_subject[name=?]", "list[subject]"

      assert_select "input#list_public_access[name=?]", "list[public_access]"
    end
  end
end
