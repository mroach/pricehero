# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20161001051449) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "brands", force: :cascade do |t|
    t.string   "name",       null: false
    t.string   "country"
    t.string   "slug"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_brands_on_deleted_at", using: :btree
    t.index ["slug"], name: "index_brands_on_slug", unique: true, using: :btree
  end

  create_table "categories", force: :cascade do |t|
    t.string   "name",       null: false
    t.string   "bulk_units"
    t.string   "slug"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.integer  "parent_id"
    t.index ["deleted_at"], name: "index_categories_on_deleted_at", using: :btree
    t.index ["slug"], name: "index_categories_on_slug", unique: true, using: :btree
  end

  create_table "category_hierarchies", id: false, force: :cascade do |t|
    t.integer "ancestor_id",   null: false
    t.integer "descendant_id", null: false
    t.integer "generations",   null: false
    t.index ["ancestor_id", "descendant_id", "generations"], name: "category_anc_desc_idx", unique: true, using: :btree
    t.index ["descendant_id"], name: "category_desc_idx", using: :btree
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
    t.index ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
    t.index ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree
  end

  create_table "products", force: :cascade do |t|
    t.integer  "brand_id"
    t.string   "name",                    null: false
    t.integer  "category_id"
    t.string   "units"
    t.string   "gtin"
    t.string   "slug"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.datetime "deleted_at"
    t.integer  "piece_count", default: 1, null: false
    t.string   "piece_name"
    t.index ["brand_id"], name: "index_products_on_brand_id", using: :btree
    t.index ["category_id"], name: "index_products_on_category_id", using: :btree
    t.index ["deleted_at"], name: "index_products_on_deleted_at", using: :btree
    t.index ["slug"], name: "index_products_on_slug", unique: true, using: :btree
  end

  create_table "reports", force: :cascade do |t|
    t.integer  "product_id"
    t.integer  "store_id"
    t.datetime "reported_at",                    null: false
    t.integer  "price_cents",    default: 0,     null: false
    t.string   "price_currency", default: "THB", null: false
    t.boolean  "out_of_stock"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_reports_on_deleted_at", using: :btree
    t.index ["product_id"], name: "index_reports_on_product_id", using: :btree
    t.index ["reported_at"], name: "index_reports_on_reported_at", using: :btree
    t.index ["store_id"], name: "index_reports_on_store_id", using: :btree
  end

  create_table "stores", force: :cascade do |t|
    t.string   "name",                 null: false
    t.string   "alternate_name"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "address"
    t.string   "locality"
    t.string   "state_province"
    t.string   "postal_code"
    t.string   "country"
    t.string   "location_description"
    t.string   "slug"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_stores_on_deleted_at", using: :btree
    t.index ["name"], name: "index_stores_on_name", using: :btree
    t.index ["slug"], name: "index_stores_on_slug", unique: true, using: :btree
  end

  create_table "versions", force: :cascade do |t|
    t.string   "item_type",      null: false
    t.integer  "item_id",        null: false
    t.string   "event",          null: false
    t.string   "whodunnit"
    t.text     "object"
    t.text     "object_changes"
    t.datetime "created_at"
    t.index ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id", using: :btree
  end

  add_foreign_key "products", "brands"
  add_foreign_key "products", "categories"
  add_foreign_key "reports", "products"
  add_foreign_key "reports", "stores"
end
