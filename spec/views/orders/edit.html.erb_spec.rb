require 'rails_helper'

RSpec.describe "orders/edit", type: :view do
  before(:each) do
    @order = assign(:order, Order.create!(
      user: nil,
      total_price: "9.99",
      status: "MyString",
      credit: "9.99",
      remarks: "MyText",
      shipping_address: "MyText",
      notification_phone_number: "MyString",
      voucher_code: "MyString",
      delivery_mode: nil
    ))
  end

  it "renders the edit order form" do
    render

    assert_select "form[action=?][method=?]", order_path(@order), "post" do

      assert_select "input[name=?]", "order[user_id]"

      assert_select "input[name=?]", "order[total_price]"

      assert_select "input[name=?]", "order[status]"

      assert_select "input[name=?]", "order[credit]"

      assert_select "textarea[name=?]", "order[remarks]"

      assert_select "textarea[name=?]", "order[shipping_address]"

      assert_select "input[name=?]", "order[notification_phone_number]"

      assert_select "input[name=?]", "order[voucher_code]"

      assert_select "input[name=?]", "order[delivery_mode_id]"
    end
  end
end
