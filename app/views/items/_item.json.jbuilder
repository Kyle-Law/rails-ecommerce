json.extract! item, :id, :name, :price, :quantity, :description, :photo_url, :brand_id, :category_id, :created_at, :updated_at
json.url item_url(item, format: :json)
