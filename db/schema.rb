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

ActiveRecord::Schema[7.1].define(version: 2024_04_01_035637) do
  create_table "customers", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.integer "tax_rate_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tax_rate_id"], name: "index_customers_on_tax_rate_id"
  end

  create_table "order_plants", force: :cascade do |t|
    t.integer "quantity"
    t.decimal "price"
    t.integer "order_id", null: false
    t.integer "plant_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_order_plants_on_order_id"
    t.index ["plant_id"], name: "index_order_plants_on_plant_id"
  end

  create_table "orders", force: :cascade do |t|
    t.integer "total"
    t.date "date"
    t.integer "customer_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_id"], name: "index_orders_on_customer_id"
  end

  create_table "plant_types", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "plants", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.decimal "price"
    t.integer "plant_type_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["plant_type_id"], name: "index_plants_on_plant_type_id"
  end

  create_table "tax_rates", force: :cascade do |t|
    t.string "province"
    t.decimal "pst"
    t.decimal "gst"
    t.decimal "hst"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "customers", "tax_rates"
  add_foreign_key "order_plants", "orders"
  add_foreign_key "order_plants", "plants"
  add_foreign_key "orders", "customers"
  add_foreign_key "plants", "plant_types"
end
