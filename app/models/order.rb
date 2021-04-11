class Order < ApplicationRecord
  belongs_to :user
  belongs_to :delivery_mode, required: false
  has_many :order_items, dependent: :destroy

  def total_quantity
    order_items.map(&:quantity).sum
  end
end
