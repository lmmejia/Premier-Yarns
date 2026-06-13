# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.1].define(version: 2026_06_12_250000) do
  create_table "cartitems", force: :cascade do |t|
    t.integer "cart_id", null: false
    t.datetime "created_at", null: false
    t.integer "order_id"
    t.integer "product_id", null: false
    t.integer "quantity"
    t.datetime "updated_at", null: false
    t.index ["cart_id"], name: "index_cartitems_on_cart_id"
    t.index ["order_id"], name: "index_cartitems_on_order_id"
    t.index ["product_id"], name: "index_cartitems_on_product_id"
  end

  create_table "carts", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.index ["user_id"], name: "index_carts_on_user_id"
  end

  create_table "orders", force: :cascade do |t|
    t.text "address"
    t.datetime "created_at", null: false
    t.string "email"
    t.string "name"
    t.string "paytype"
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "products", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.text "description"
    t.string "image"
    t.string "name"
    t.decimal "price"
    t.datetime "updated_at", null: false
  end

  create_table "reviews", force: :cascade do |t|
    t.text "comment", null: false
    t.datetime "created_at", null: false
    t.integer "product_id", null: false
    t.integer "rating", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.index ["product_id"], name: "index_reviews_on_product_id"
    t.index ["user_id"], name: "index_reviews_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.boolean "admin", default: false, null: false
    t.datetime "created_at", null: false
    t.string "email", null: false
    t.string "password_digest", null: false
    t.datetime "updated_at", null: false
    t.string "userid", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["userid"], name: "index_users_on_userid", unique: true
  end

  add_foreign_key "cartitems", "carts"
  add_foreign_key "cartitems", "orders"
  add_foreign_key "cartitems", "products"
  add_foreign_key "carts", "users"
  add_foreign_key "orders", "users"
  add_foreign_key "reviews", "products"
  add_foreign_key "reviews", "users"
end
