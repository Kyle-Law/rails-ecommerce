class Order < ApplicationRecord
  belongs_to :user
  belongs_to :delivery_mode, required: false
  has_many :order_items, dependent: :destroy
  before_save :set_attributes

  def idify
    "RAILS_CONF_#{id}"
  end

  def total_quantity
    order_items.map(&:quantity).sum
  end

  def promotion_book
    book = {}
    order_items.each do |oi|
      oi.item.current_all_promotions.each do |p|
        book[p] ||= Hash.new(0)
        p.mixable ? book[p]['mix'] += oi.quantity : book[p][oi] += oi.quantity
      end
    end
    book
  end

  private

  def set_attributes
    self[:total_price] = order_items.map(&:sub_total).sum || 0
    self[:notification_phone_number] ||= user.phone
  end
end
