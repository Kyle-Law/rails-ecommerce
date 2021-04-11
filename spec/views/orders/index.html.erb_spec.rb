require 'rails_helper'

RSpec.describe "orders/index", type: :view do
  before(:each) do
    assign(:orders, [
      Order.create!(
        user: nil,
        total_price: "9.99",
        status: "Status",
        credit: "9.99",
        remarks: "MyText",
        shipping_address: "MyText",
        notification_phone_number: "Notification Phone Number",
        voucher_code: "Voucher Code",
        delivery_mode: nil
      ),
      Order.create!(
        user: nil,
        total_price: "9.99",
        status: "Status",
        credit: "9.99",
        remarks: "MyText",
        shipping_address: "MyText",
        notification_phone_number: "Notification Phone Number",
        voucher_code: "Voucher Code",
        delivery_mode: nil
      )
    ])
  end

  it "renders a list of orders" do
    render
    assert_select "tr>td", text: nil.to_s, count: 2
    assert_select "tr>td", text: "9.99".to_s, count: 2
    assert_select "tr>td", text: "Status".to_s, count: 2
    assert_select "tr>td", text: "9.99".to_s, count: 2
    assert_select "tr>td", text: "MyText".to_s, count: 2
    assert_select "tr>td", text: "MyText".to_s, count: 2
    assert_select "tr>td", text: "Notification Phone Number".to_s, count: 2
    assert_select "tr>td", text: "Voucher Code".to_s, count: 2
    assert_select "tr>td", text: nil.to_s, count: 2
  end
end
