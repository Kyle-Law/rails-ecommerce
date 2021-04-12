# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_04_12_060503) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "brands", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "delivery_modes", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "items", force: :cascade do |t|
    t.string "name"
    t.decimal "price"
    t.integer "quantity"
    t.text "description"
    t.string "photo_url"
    t.bigint "brand_id", null: false
    t.bigint "category_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "is_promo"
    t.index ["brand_id"], name: "index_items_on_brand_id"
    t.index ["category_id"], name: "index_items_on_category_id"
  end

  create_table "items_promotions", id: false, force: :cascade do |t|
    t.bigint "promotion_id", null: false
    t.bigint "item_id", null: false
    t.index ["item_id", "promotion_id"], name: "index_items_promotions_on_item_id_and_promotion_id"
    t.index ["promotion_id", "item_id"], name: "index_items_promotions_on_promotion_id_and_item_id"
  end

  create_table "order_items", force: :cascade do |t|
    t.bigint "item_id", null: false
    t.bigint "order_id", null: false
    t.integer "quantity"
    t.decimal "unit_price"
    t.decimal "unit_discount"
    t.decimal "sub_total"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["item_id"], name: "index_order_items_on_item_id"
    t.index ["order_id"], name: "index_order_items_on_order_id"
  end

  create_table "orders", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.decimal "total_price"
    t.string "status"
    t.decimal "credit"
    t.text "remarks"
    t.text "shipping_address"
    t.string "notification_phone_number"
    t.string "voucher_code"
    t.bigint "delivery_mode_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "order_date"
    t.index ["delivery_mode_id"], name: "index_orders_on_delivery_mode_id"
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "promotions", force: :cascade do |t|
    t.string "name"
    t.string "message"
    t.integer "min"
    t.boolean "mixable"
    t.decimal "discount_fixed"
    t.decimal "discount_percent"
    t.string "gift"
    t.integer "gift_quantity"
    t.date "date_start"
    t.date "date_end"
    t.string "voucher_code"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "item_categories", default: [], array: true
    t.string "item_brands", default: [], array: true
    t.string "item_keyword", default: [], array: true
    t.string "description"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "show_price"
    t.decimal "credit"
    t.string "phone"
    t.string "address"
    t.bigint "role_id", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["role_id"], name: "index_users_on_role_id"
  end

  add_foreign_key "items", "brands"
  add_foreign_key "items", "categories"
  add_foreign_key "order_items", "items"
  add_foreign_key "order_items", "orders"
  add_foreign_key "orders", "delivery_modes"
  add_foreign_key "orders", "users"
  add_foreign_key "users", "roles"
end
