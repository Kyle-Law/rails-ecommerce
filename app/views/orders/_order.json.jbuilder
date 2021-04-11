json.extract! order, :id, :user_id, :total_price, :status, :credit, :remarks, :shipping_address, :notification_phone_number, :voucher_code, :delivery_mode_id, :created_at, :updated_at
json.url order_url(order, format: :json)
