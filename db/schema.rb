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

ActiveRecord::Schema.define(version: 20140318221901) do

  create_table "organizations", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "plans", force: true do |t|
    t.string   "paymill_id"
    t.string   "name"
    t.float    "price"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "project_invites", force: true do |t|
    t.boolean  "accepted"
    t.string   "email"
    t.string   "key"
    t.integer  "project_id"
    t.integer  "user_id"
    t.integer  "sender_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "project_invites", ["project_id"], name: "index_project_invites_on_project_id"

  create_table "project_members", force: true do |t|
    t.string   "role"
    t.integer  "project_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "project_members", ["project_id"], name: "index_project_members_on_project_id"
  add_index "project_members", ["user_id"], name: "index_project_members_on_user_id"

  create_table "project_stories", force: true do |t|
    t.string   "title"
    t.text     "body"
    t.boolean  "closed"
    t.integer  "project_id"
    t.integer  "owner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "assigned_to_id"
    t.integer  "priority",       default: 0
    t.date     "due_at"
    t.integer  "comments_count", default: 0
  end

  add_index "project_stories", ["assigned_to_id"], name: "index_project_stories_on_assigned_to_id"
  add_index "project_stories", ["owner_id"], name: "index_project_stories_on_owner_id"
  add_index "project_stories", ["project_id"], name: "index_project_stories_on_project_id"

  create_table "project_teams", force: true do |t|
    t.integer  "project_id"
    t.integer  "team_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "project_teams", ["project_id"], name: "index_project_teams_on_project_id"
  add_index "project_teams", ["team_id"], name: "index_project_teams_on_team_id"

  create_table "projects", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "members_count",   default: 0
    t.integer  "organization_id"
    t.integer  "owner_id"
  end

  add_index "projects", ["organization_id"], name: "index_projects_on_organization_id"

  create_table "story_comments", force: true do |t|
    t.integer  "user_id"
    t.integer  "project_story_id"
    t.string   "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "story_comments", ["project_story_id"], name: "index_story_comments_on_project_story_id"
  add_index "story_comments", ["user_id"], name: "index_story_comments_on_user_id"

  create_table "subscriptions", force: true do |t|
    t.integer  "plan_id"
    t.integer  "user_id"
    t.string   "paymill_card_token"
    t.string   "paymill_card_last"
    t.string   "paymill_id"
    t.boolean  "active"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "organization_id"
  end

  add_index "subscriptions", ["organization_id"], name: "index_subscriptions_on_organization_id"
  add_index "subscriptions", ["plan_id"], name: "index_subscriptions_on_plan_id"
  add_index "subscriptions", ["user_id"], name: "index_subscriptions_on_user_id"

  create_table "team_invites", force: true do |t|
    t.boolean  "accepted"
    t.string   "email"
    t.string   "key"
    t.integer  "sender_id"
    t.integer  "user_id"
    t.integer  "team_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "team_invites", ["sender_id"], name: "index_team_invites_on_sender_id"
  add_index "team_invites", ["team_id"], name: "index_team_invites_on_team_id"
  add_index "team_invites", ["user_id"], name: "index_team_invites_on_user_id"

  create_table "team_members", force: true do |t|
    t.string   "role"
    t.integer  "user_id"
    t.integer  "team_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "team_members", ["team_id"], name: "index_team_members_on_team_id"
  add_index "team_members", ["user_id"], name: "index_team_members_on_user_id"

  create_table "teams", force: true do |t|
    t.string   "name"
    t.integer  "organization_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "members_count",   default: 0
    t.string   "role"
  end

  add_index "teams", ["organization_id"], name: "index_teams_on_organization_id"

  create_table "users", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_active"
    t.boolean  "email_verified"
    t.string   "full_name"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "client_id"
    t.string   "request_token"
  end

  add_index "users", ["email"], name: "index_users_on_email"
  add_index "users", ["full_name"], name: "full_name_index"
  add_index "users", ["is_active"], name: "index_users_on_is_active"

end
