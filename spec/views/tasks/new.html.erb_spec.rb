require 'rails_helper'

RSpec.describe "tasks/new", type: :view do
  before(:each) do
    assign(:task, Task.new(
      :list => nil,
      :description => "MyText"
    ))
  end

  it "renders new task form" do
    render

    assert_select "form[action=?][method=?]", tasks_path, "post" do

      assert_select "input#task_list_id[name=?]", "task[list_id]"

      assert_select "textarea#task_description[name=?]", "task[description]"
    end
  end
end
