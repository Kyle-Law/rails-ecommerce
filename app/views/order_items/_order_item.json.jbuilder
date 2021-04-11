json.extract! order_item, :id, :item_id, :order_id, :quantity, :unit_price, :unit_discount, :sub_total, :created_at, :updated_at
json.url order_item_url(order_item, format: :json)
