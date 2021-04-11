require 'rails_helper'

RSpec.describe "promotions/show", type: :view do
  before(:each) do
    @promotion = assign(:promotion, Promotion.create!(
      name: "Name",
      message: "Message",
      min: 2,
      mixable: false,
      discount_fixed: "9.99",
      discount_percent: "9.99",
      gift: "Gift",
      gift_quantity: 3,
      voucher_code: "Voucher Code"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Message/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(/Gift/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(/Voucher Code/)
  end
end
