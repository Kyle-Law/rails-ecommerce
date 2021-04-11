require 'rails_helper'

RSpec.describe "promotions/edit", type: :view do
  before(:each) do
    @promotion = assign(:promotion, Promotion.create!(
      name: "MyString",
      message: "MyString",
      min: 1,
      mixable: false,
      discount_fixed: "9.99",
      discount_percent: "9.99",
      gift: "MyString",
      gift_quantity: 1,
      voucher_code: "MyString"
    ))
  end

  it "renders the edit promotion form" do
    render

    assert_select "form[action=?][method=?]", promotion_path(@promotion), "post" do

      assert_select "input[name=?]", "promotion[name]"

      assert_select "input[name=?]", "promotion[message]"

      assert_select "input[name=?]", "promotion[min]"

      assert_select "input[name=?]", "promotion[mixable]"

      assert_select "input[name=?]", "promotion[discount_fixed]"

      assert_select "input[name=?]", "promotion[discount_percent]"

      assert_select "input[name=?]", "promotion[gift]"

      assert_select "input[name=?]", "promotion[gift_quantity]"

      assert_select "input[name=?]", "promotion[voucher_code]"
    end
  end
end
