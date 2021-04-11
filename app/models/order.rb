class Order < ApplicationRecord
  belongs_to :user
  belongs_to :delivery_mode, required: false
  has_many :order_items, dependent: :destroy
  before_save :set_attributes

  def total_quantity
    order_items.map(&:quantity).sum
  end

  private

  def set_attributes
    self[:total_price] = order_items.map(&:sub_total).sum || 0
    self[:notification_phone_number] ||= user.phone
  end
end
