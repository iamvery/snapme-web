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

ActiveRecord::Schema.define(version: 20130803213643) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "invitations", force: true do |t|
    t.string "token", null: false
  end

  add_index "invitations", ["token"], name: "index_invitations_on_token", unique: true, using: :btree

  create_table "memberships", force: true do |t|
    t.integer "user_id", null: false
    t.integer "team_id", null: false
  end

  add_index "memberships", ["team_id", "user_id"], name: "index_memberships_on_team_id_and_user_id", unique: true, using: :btree

  create_table "teams", force: true do |t|
    t.string "name", null: false
  end

  create_table "users", force: true do |t|
    t.string "provider",   null: false
    t.string "uid",        null: false
    t.string "username",   null: false
    t.string "snapshot"
    t.string "auth_token"
  end

  add_index "users", ["auth_token"], name: "index_users_on_auth_token", unique: true, using: :btree
  add_index "users", ["provider", "uid", "username"], name: "index_users_on_provider_and_uid_and_username", unique: true, using: :btree
  add_index "users", ["provider", "uid"], name: "index_users_on_provider_and_uid", unique: true, using: :btree

  add_foreign_key "memberships", "teams", :name => "memberships_team_id_fk", :dependent => :delete
  add_foreign_key "memberships", "users", :name => "memberships_user_id_fk", :dependent => :delete

end
