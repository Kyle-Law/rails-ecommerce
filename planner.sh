# Generate models and scaffolds
rails g scaffold brand name
rails g scaffold category name
rails g scaffold promotion name message min:integer mixable:boolean discount_fixed:decimal discount_percent:decimal gift gift_quantity:integer date_start:date date_end:date voucher_code
rails g scaffold item name price:decimal quantity:integer description:text photo_url brand:references category:references
rails g model delivery_mode name
rails g scaffold order user:references total_price:decimal status credit:decimal remarks:text shipping_address:text notification_phone_number voucher_code delivery_mode:references
rails g scaffold order_item item:references order:references quantity:integer unit_price:decimal unit_discount:decimal sub_total:decimal
rails g migration CreateJoinTablePromotionItem promotions items

rails db:migrate

# Generate scaffold views based on templates
rails g erb:scaffold brand name
rails g erb:scaffold category name
rails g erb:scaffold promotion name message min:integer mixable:boolean discount_fixed:decimal discount_percent:decimal gift gift_quantity:integer date_start:date date_end:date voucher_code
rails g erb:scaffold item name price:decimal quantity:integer description:text photo_url brand:references category:references
rails g erb:scaffold order user:references total_price:decimal status credit:decimal remarks:text shipping_address:text notification_phone_number voucher_code delivery_mode:references
rails g erb:scaffold order_item item:references order:references quantity:integer unit_price:decimal unit_discount:decimal sub_total:decimal
