require 'rails_helper'

RSpec.describe "order_items/edit", type: :view do
  before(:each) do
    @order_item = assign(:order_item, OrderItem.create!(
      item: nil,
      order: nil,
      quantity: 1,
      unit_price: "9.99",
      unit_discount: "9.99",
      sub_total: "9.99"
    ))
  end

  it "renders the edit order_item form" do
    render

    assert_select "form[action=?][method=?]", order_item_path(@order_item), "post" do

      assert_select "input[name=?]", "order_item[item_id]"

      assert_select "input[name=?]", "order_item[order_id]"

      assert_select "input[name=?]", "order_item[quantity]"

      assert_select "input[name=?]", "order_item[unit_price]"

      assert_select "input[name=?]", "order_item[unit_discount]"

      assert_select "input[name=?]", "order_item[sub_total]"
    end
  end
end
