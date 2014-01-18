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

ActiveRecord::Schema.define(version: 20140118175117) do

  create_table "invites", force: true do |t|
    t.boolean  "accepted"
    t.string   "email"
    t.string   "key"
    t.integer  "project_id"
    t.integer  "user_id"
    t.integer  "sender_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "invites", ["project_id"], name: "index_invites_on_project_id"

  create_table "project_members", force: true do |t|
    t.string   "role"
    t.integer  "project_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "project_members", ["project_id"], name: "index_project_members_on_project_id"
  add_index "project_members", ["user_id"], name: "index_project_members_on_user_id"

  create_table "projects", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "members_count", default: 0
  end

  create_table "users", force: true do |t|
    t.string   "username"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_active"
    t.boolean  "email_verified"
  end

  add_index "users", ["email"], name: "index_users_on_email"
  add_index "users", ["is_active"], name: "index_users_on_is_active"
  add_index "users", ["username"], name: "username_index"

end
