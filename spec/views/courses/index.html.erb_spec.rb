require 'rails_helper'

RSpec.describe "courses/index", type: :view do
  before(:each) do
    assign(:courses, [
      Course.create!(
        title: "Title",
        description: "Description"
      ),
      Course.create!(
        title: "Title",
        description: "Description"
      )
    ])
  end

  it "renders a list of courses" do
    render
    assert_select "tr>td", text: "Title".to_s, count: 2
    assert_select "tr>td", text: "Description".to_s, count: 2
  end
end
