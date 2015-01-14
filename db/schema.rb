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

ActiveRecord::Schema.define(version: 20140506055758) do

  create_table "batches", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "unfollowed"
    t.datetime "unfollowed_not_followers"
    t.integer  "user_id"
  end

  create_table "instagram_users", force: true do |t|
    t.string   "instagram_id"
    t.string   "image_url"
    t.string   "comment"
    t.string   "name"
    t.string   "instagram_name"
    t.datetime "followed"
    t.datetime "unfollowed"
    t.boolean  "followed_back"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "error"
    t.integer  "batch_id"
    t.integer  "user_id"
    t.string   "parent_instagram_id"
  end

  add_index "instagram_users", ["instagram_id"], name: "index_instagram_users_on_instagram_id_and_user_id", unique: true

  create_table "users", force: true do |t|
    t.string   "app_id"
    t.string   "app_secret"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "instagram_id"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
