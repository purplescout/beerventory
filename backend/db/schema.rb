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

ActiveRecord::Schema.define(version: 20150331171848) do

  create_table "beers", force: :cascade do |t|
    t.string  "barcode", null: false
    t.string  "name",    null: false
    t.decimal "volume"
  end

  add_index "beers", ["barcode"], name: "index_beers_on_barcode", unique: true

  create_table "histories", force: :cascade do |t|
    t.integer "user_id",                     null: false
    t.integer "organization_id",             null: false
    t.integer "beer_id",                     null: false
    t.integer "in",              default: 0, null: false
    t.integer "out",             default: 0, null: false
  end

  add_index "histories", ["user_id", "organization_id", "beer_id"], name: "index_histories_on_user_id_and_organization_id_and_beer_id", unique: true

  create_table "inventories", force: :cascade do |t|
    t.integer "organization_id",             null: false
    t.integer "beer_id",                     null: false
    t.integer "amount",          default: 0, null: false
  end

  add_index "inventories", ["organization_id", "beer_id"], name: "index_inventories_on_organization_id_and_beer_id", unique: true

  create_table "memberships", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "organization_id"
    t.string   "role"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "memberships", ["user_id", "organization_id"], name: "index_memberships_on_user_id_and_organization_id", unique: true

  create_table "organizations", force: :cascade do |t|
    t.string   "name",       null: false
    t.string   "code",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "organizations", ["code"], name: "index_organizations_on_code", unique: true

  create_table "users", force: :cascade do |t|
    t.string   "email",                                        null: false
    t.string   "crypted_password",                             null: false
    t.string   "salt",                                         null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_me_token"
    t.datetime "remember_me_token_expires_at"
    t.string   "reset_password_token"
    t.datetime "reset_password_token_expires_at"
    t.datetime "reset_password_email_sent_at"
    t.string   "api_token",                                    null: false
    t.string   "name",                            default: "", null: false
  end

  add_index "users", ["api_token"], name: "index_users_on_api_token", unique: true
  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["remember_me_token"], name: "index_users_on_remember_me_token"
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token"

end
