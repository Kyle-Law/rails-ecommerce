class Item < ApplicationRecord
  belongs_to :brand
  belongs_to :category
  has_and_belongs_to_many :promotions
  has_many :order_items, dependent: :destroy

end
