class OrderItem < ApplicationRecord
  belongs_to :item
  belongs_to :order

  before_save :set_unit_price
  before_save :set_sub_total

  before_save :set_attributes

  private

  def set_attributes
    self[:unit_price] = item.price
    self[:sub_total] = (unit_price.to_f - unit_discount.to_f) * quantity.to_i
  end

  def set_unit_price
    self[:unit_price] = item.price
  end

  def set_sub_total
    self[:sub_total] = (unit_price.to_f - unit_discount.to_f) * quantity.to_i
  end
end
