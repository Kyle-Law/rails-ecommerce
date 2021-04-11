json.extract! promotion, :id, :name, :message, :min, :mixable, :discount_fixed, :discount_percent, :gift, :gift_quantity, :date_start, :date_end, :voucher_code, :created_at, :updated_at
json.url promotion_url(promotion, format: :json)
