class Order < ApplicationRecord
  belongs_to :user
  belongs_to :delivery_mode, required: false
  has_many :order_items, dependent: :destroy
end
