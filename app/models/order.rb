class Order < ApplicationRecord
  belongs_to :user
  belongs_to :delivery_mode
end
