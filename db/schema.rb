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

ActiveRecord::Schema.define(version: 2023_12_20_151928) do

  create_table "admins", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "customers", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "name", null: false
    t.integer "status", default: 0, null: false
    t.string "image_url"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_customers_on_email", unique: true
    t.index ["reset_password_token"], name: "index_customers_on_reset_password_token", unique: true
  end

  create_table "like_places", force: :cascade do |t|
    t.integer "customer_id"
    t.integer "place_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["customer_id"], name: "index_like_places_on_customer_id"
    t.index ["place_id"], name: "index_like_places_on_place_id"
  end

  create_table "place_images", force: :cascade do |t|
    t.string "image_url", null: false
    t.integer "place_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["place_id"], name: "index_place_images_on_place_id"
  end

  create_table "places", force: :cascade do |t|
    t.string "name", null: false
    t.string "address"
    t.float "rating_avg"
    t.decimal "longitude", precision: 10, scale: 7, null: false
    t.decimal "latitude", precision: 10, scale: 7, null: false
    t.string "phone_number"
    t.string "opening_hours"
    t.string "website"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "reviews", force: :cascade do |t|
    t.text "comment", null: false
    t.integer "rating_1", null: false
    t.integer "rating_2", null: false
    t.integer "rating_3", null: false
    t.integer "rating_4", null: false
    t.integer "rating_5", null: false
    t.integer "customer_id"
    t.integer "place_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["customer_id"], name: "index_reviews_on_customer_id"
    t.index ["place_id"], name: "index_reviews_on_place_id"
  end

  add_foreign_key "like_places", "customers"
  add_foreign_key "like_places", "places"
  add_foreign_key "place_images", "places"
  add_foreign_key "reviews", "customers"
  add_foreign_key "reviews", "places"
end
