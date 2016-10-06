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

ActiveRecord::Schema.define(version: 20161006025817) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "brands", force: :cascade do |t|
    t.string   "name",       null: false
    t.string   "country"
    t.string   "slug"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.string   "logo"
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

  create_table "identities", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "provider",   null: false
    t.string   "uid",        null: false
    t.jsonb    "info"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_identities_on_deleted_at", using: :btree
    t.index ["provider", "uid"], name: "index_identities_on_provider_and_uid", unique: true, using: :btree
    t.index ["user_id", "provider"], name: "index_identities_on_user_id_and_provider", unique: true, using: :btree
    t.index ["user_id"], name: "index_identities_on_user_id", using: :btree
  end

  create_table "product_media", force: :cascade do |t|
    t.integer  "product_id",               null: false
    t.string   "file",                     null: false
    t.string   "content_type",             null: false
    t.integer  "size",         default: 0, null: false
    t.string   "title"
    t.integer  "position"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_product_media_on_deleted_at", using: :btree
    t.index ["product_id"], name: "index_product_media_on_product_id", using: :btree
  end

  create_table "products", force: :cascade do |t|
    t.integer  "brand_id"
    t.integer  "category_id", null: false
    t.string   "name",        null: false
    t.string   "slug"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.datetime "deleted_at"
    t.index ["brand_id"], name: "index_products_on_brand_id", using: :btree
    t.index ["category_id"], name: "index_products_on_category_id", using: :btree
    t.index ["deleted_at"], name: "index_products_on_deleted_at", using: :btree
    t.index ["slug"], name: "index_products_on_slug", unique: true, using: :btree
  end

  create_table "reports", force: :cascade do |t|
    t.integer  "variant_id"
    t.integer  "store_id"
    t.datetime "reported_at",                    null: false
    t.integer  "price_cents",    default: 0,     null: false
    t.string   "price_currency", default: "THB", null: false
    t.boolean  "out_of_stock"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.datetime "deleted_at"
    t.integer  "user_id"
    t.index ["deleted_at"], name: "index_reports_on_deleted_at", using: :btree
    t.index ["reported_at"], name: "index_reports_on_reported_at", using: :btree
    t.index ["store_id"], name: "index_reports_on_store_id", using: :btree
    t.index ["user_id"], name: "index_reports_on_user_id", using: :btree
    t.index ["variant_id"], name: "index_reports_on_variant_id", using: :btree
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

  create_table "users", force: :cascade do |t|
    t.string   "email",                            null: false
    t.string   "encrypted_password",  default: "", null: false
    t.string   "name",                             null: false
    t.string   "nickname"
    t.string   "slug"
    t.integer  "role",                default: 0,  null: false
    t.datetime "remember_created_at"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_users_on_deleted_at", using: :btree
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["slug"], name: "index_users_on_slug", unique: true, using: :btree
  end

  create_table "variants", force: :cascade do |t|
    t.string   "units"
    t.string   "slug"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.datetime "deleted_at"
    t.integer  "piece_count", default: 1, null: false
    t.string   "piece_name"
    t.integer  "product_id",              null: false
    t.string   "gtin"
    t.index ["deleted_at"], name: "index_variants_on_deleted_at", using: :btree
    t.index ["slug"], name: "index_variants_on_slug", unique: true, using: :btree
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

  add_foreign_key "identities", "users"
  add_foreign_key "product_media", "products"
  add_foreign_key "products", "brands"
  add_foreign_key "products", "categories"
  add_foreign_key "reports", "stores"
  add_foreign_key "reports", "users"
  add_foreign_key "reports", "variants"
  add_foreign_key "variants", "products"
end
