require 'rails_helper'

RSpec.describe "items/edit", type: :view do
  before(:each) do
    @item = assign(:item, Item.create!(
      name: "MyString",
      price: "9.99",
      quantity: 1,
      description: "MyText",
      photo_url: "MyString",
      brand: nil,
      category: nil
    ))
  end

  it "renders the edit item form" do
    render

    assert_select "form[action=?][method=?]", item_path(@item), "post" do

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
