# Generate models and scaffolds
# Setup Devise
rails app:template LOCATION='https://railsbytes.com/script/X8Bsjx'
# Setup RSpec
rails app:template LOCATION='https://railsbytes.com/script/z0gsLX'
# Setup Role, User, and user attributes~

rails g model role name
rails g migration AddAttributesToUsers show_price:boolean credit:decimal phone:string address:string role:references

# Setup brand, category, promotion, item, delivery_mode, order, order_item,
rails g scaffold brand name
rails g scaffold category name
rails g scaffold promotion name message min:integer mixable:boolean discount_fixed:decimal discount_percent:decimal gift gift_quantity:integer date_start:date date_end:date voucher_code
rails g scaffold item name price:decimal quantity:integer description:text photo_url brand:references category:references
rails g model delivery_mode name
rails g scaffold order user:references total_price:decimal status credit:decimal remarks:text shipping_address:text notification_phone_number voucher_code delivery_mode:references
rails g scaffold order_item item:references order:references quantity:integer unit_price:decimal unit_discount:decimal sub_total:decimal

# HABTM relationship beteween promo & item
rails g migration CreateJoinTablePromotionItem promotions items

#### Set null:true for Order model before migration ####

# rails db:migrate

# Customize scaffolded viewsp
rails g erb:scaffold brand name
rails g erb:scaffold category name
rails g erb:scaffold promotion name message min:integer mixable:boolean discount_fixed:decimal discount_percent:decimal gift gift_quantity:integer date_start:date date_end:date voucher_code
rails g erb:scaffold item name price:decimal quantity:integer description:text photo_url brand:references category:references
rails g erb:scaffold order user:references total_price:decimal status credit:decimal remarks:text shipping_address:text notification_phone_number voucher_code delivery_mode:references
rails g erb:scaffold order_item item:references order:references quantity:integer unit_price:decimal unit_discount:decimal sub_total:decimal

# Add item attributes to promotion
# Manually add `array: true, default: []` in the migration file
rails g migration AddAttributesToPromotions item_categories item_brands item_keyword

# Additional migrations
rails g migration AddIsPromoToItems is_promo:boolean
