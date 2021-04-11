require 'rails_helper'

RSpec.describe "order_items/index", type: :view do
  before(:each) do
    assign(:order_items, [
      OrderItem.create!(
        item: nil,
        order: nil,
        quantity: 2,
        unit_price: "9.99",
        unit_discount: "9.99",
        sub_total: "9.99"
      ),
      OrderItem.create!(
        item: nil,
        order: nil,
        quantity: 2,
        unit_price: "9.99",
        unit_discount: "9.99",
        sub_total: "9.99"
      )
    ])
  end

  it "renders a list of order_items" do
    render
    assert_select "tr>td", text: nil.to_s, count: 2
    assert_select "tr>td", text: nil.to_s, count: 2
    assert_select "tr>td", text: 2.to_s, count: 2
    assert_select "tr>td", text: "9.99".to_s, count: 2
    assert_select "tr>td", text: "9.99".to_s, count: 2
    assert_select "tr>td", text: "9.99".to_s, count: 2
  end
end
