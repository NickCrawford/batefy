# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20150125050853) do

  create_table "businesses", force: true do |t|
    t.string   "email",              limit: 254, null: false
    t.string   "name",               limit: 50,  null: false
    t.float    "latitude",           limit: 24,  null: false
    t.float    "longitude",          limit: 24,  null: false
    t.string   "website"
    t.string   "phone"
    t.string   "address"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "country"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "password_digest"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  add_index "businesses", ["email"], name: "index_businesses_on_email", unique: true, using: :btree

  create_table "businesses_subtags", id: false, force: true do |t|
    t.integer "business_id"
    t.integer "subtag_id"
  end

  add_index "businesses_subtags", ["business_id", "subtag_id"], name: "index_businesses_subtags_on_business_id_and_subtag_id", using: :btree

  create_table "businesses_tags", id: false, force: true do |t|
    t.integer "business_id"
    t.integer "tag_id"
  end

  add_index "businesses_tags", ["business_id", "tag_id"], name: "index_businesses_tags_on_business_id_and_tag_id", using: :btree

  create_table "offer_dates", force: true do |t|
    t.integer  "offer_id"
    t.integer  "visible_from"
    t.integer  "start_time"
    t.integer  "end_time"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "offer_dates", ["offer_id"], name: "index_offer_dates_on_offer_id", using: :btree

  create_table "offers", force: true do |t|
    t.integer  "business_id"
    t.integer  "percentage"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "active"
  end

  create_table "subtags", force: true do |t|
    t.integer  "tag_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "subtags", ["tag_id"], name: "index_subtags_on_tag_id", using: :btree

  create_table "tags", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_business_opinions", force: true do |t|
    t.integer  "business_id"
    t.integer  "user_id"
    t.integer  "opinion"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_business_opinions", ["business_id", "user_id"], name: "index_user_business_opinions_on_business_id_and_user_id", using: :btree

  create_table "user_offer_opinions", force: true do |t|
    t.integer  "offer_id"
    t.integer  "user_id"
    t.integer  "opinion"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_offer_opinions", ["offer_id", "user_id"], name: "index_user_offer_opinions_on_offer_id_and_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",              limit: 254, null: false
    t.string   "first_name",         limit: 15
    t.string   "last_name",          limit: 15
    t.date     "birthday"
    t.integer  "gender",             limit: 1
    t.float    "latitude_home",      limit: 24
    t.float    "longitude_home",     limit: 24
    t.float    "latitude_current",   limit: 24
    t.float    "longitutde_current", limit: 24
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
  end

end
