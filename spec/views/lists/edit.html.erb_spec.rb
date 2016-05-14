require 'rails_helper'

RSpec.describe "lists/edit", type: :view do
  before(:each) do
    @list = assign(:list, List.create!(
      :subject => "MyString",
      :public_access => false
    ))
  end

  it "renders the edit list form" do
    render

    assert_select "form[action=?][method=?]", list_path(@list), "post" do

      assert_select "input#list_subject[name=?]", "list[subject]"

      assert_select "input#list_public_access[name=?]", "list[public_access]"
    end
  end
end
