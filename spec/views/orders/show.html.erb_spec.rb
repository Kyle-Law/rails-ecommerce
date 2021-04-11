require 'rails_helper'

RSpec.describe "orders/show", type: :view do
  before(:each) do
    @order = assign(:order, Order.create!(
      user: nil,
      total_price: "9.99",
      status: "Status",
      credit: "9.99",
      remarks: "MyText",
      shipping_address: "MyText",
      notification_phone_number: "Notification Phone Number",
      voucher_code: "Voucher Code",
      delivery_mode: nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(/Status/)
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/Notification Phone Number/)
    expect(rendered).to match(/Voucher Code/)
    expect(rendered).to match(//)
  end
end
