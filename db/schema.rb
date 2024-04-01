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

ActiveRecord::Schema[7.1].define(version: 2024_04_01_195410) do
  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

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
    t.string "other_name"
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

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "customers", "tax_rates"
  add_foreign_key "order_plants", "orders"
  add_foreign_key "order_plants", "plants"
  add_foreign_key "orders", "customers"
  add_foreign_key "plants", "plant_types"
end
