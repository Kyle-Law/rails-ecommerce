require 'rails_helper'

RSpec.describe "items/index", type: :view do
  before(:each) do
    assign(:items, [
      Item.create!(
        name: "Name",
        price: "9.99",
        quantity: 2,
        description: "MyText",
        photo_url: "Photo Url",
        brand: nil,
        category: nil
      ),
      Item.create!(
        name: "Name",
        price: "9.99",
        quantity: 2,
        description: "MyText",
        photo_url: "Photo Url",
        brand: nil,
        category: nil
      )
    ])
  end

  it "renders a list of items" do
    render
    assert_select "tr>td", text: "Name".to_s, count: 2
    assert_select "tr>td", text: "9.99".to_s, count: 2
    assert_select "tr>td", text: 2.to_s, count: 2
    assert_select "tr>td", text: "MyText".to_s, count: 2
    assert_select "tr>td", text: "Photo Url".to_s, count: 2
    assert_select "tr>td", text: nil.to_s, count: 2
    assert_select "tr>td", text: nil.to_s, count: 2
  end
end
