require 'rails_helper'

RSpec.describe "promotions/index", type: :view do
  before(:each) do
    assign(:promotions, [
      Promotion.create!(
        name: "Name",
        message: "Message",
        min: 2,
        mixable: false,
        discount_fixed: "9.99",
        discount_percent: "9.99",
        gift: "Gift",
        gift_quantity: 3,
        voucher_code: "Voucher Code"
      ),
      Promotion.create!(
        name: "Name",
        message: "Message",
        min: 2,
        mixable: false,
        discount_fixed: "9.99",
        discount_percent: "9.99",
        gift: "Gift",
        gift_quantity: 3,
        voucher_code: "Voucher Code"
      )
    ])
  end

  it "renders a list of promotions" do
    render
    assert_select "tr>td", text: "Name".to_s, count: 2
    assert_select "tr>td", text: "Message".to_s, count: 2
    assert_select "tr>td", text: 2.to_s, count: 2
    assert_select "tr>td", text: false.to_s, count: 2
    assert_select "tr>td", text: "9.99".to_s, count: 2
    assert_select "tr>td", text: "9.99".to_s, count: 2
    assert_select "tr>td", text: "Gift".to_s, count: 2
    assert_select "tr>td", text: 3.to_s, count: 2
    assert_select "tr>td", text: "Voucher Code".to_s, count: 2
  end
end
