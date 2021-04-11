require 'rails_helper'

RSpec.describe "items/new", type: :view do
  before(:each) do
    assign(:item, Item.new(
      name: "MyString",
      price: "9.99",
      quantity: 1,
      description: "MyText",
      photo_url: "MyString",
      brand: nil,
      category: nil
    ))
  end

  it "renders new item form" do
    render

    assert_select "form[action=?][method=?]", items_path, "post" do

      assert_select "input[name=?]", "item[name]"

      assert_select "input[name=?]", "item[price]"

      assert_select "input[name=?]", "item[quantity]"

      assert_select "textarea[name=?]", "item[description]"

      assert_select "input[name=?]", "item[photo_url]"

      assert_select "input[name=?]", "item[brand_id]"

      assert_select "input[name=?]", "item[category_id]"
    end
  end
end
