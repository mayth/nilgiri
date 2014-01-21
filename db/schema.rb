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

ActiveRecord::Schema.define(version: 20140121232329) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "friendly_id_slugs", force: true do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree

  create_table "machines", force: true do |t|
    t.string   "name"
    t.string   "slug"
    t.string   "difficulties"
    t.string   "playstyles"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "machines", ["slug"], name: "index_machines_on_slug", unique: true, using: :btree

  create_table "musics", force: true do |t|
    t.string   "name"
    t.string   "artist"
    t.integer  "machine_id"
    t.integer  "season_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "musics", ["machine_id"], name: "index_musics_on_machine_id", using: :btree
  add_index "musics", ["season_id"], name: "index_musics_on_season_id", using: :btree

  create_table "players", force: true do |t|
    t.string   "name"
    t.string   "screen_name"
    t.string   "password"
    t.string   "twitter_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "players", ["name"], name: "index_players_on_name", unique: true, using: :btree

  create_table "posts", force: true do |t|
    t.string   "title"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug"
  end

  add_index "posts", ["slug"], name: "index_posts_on_slug", unique: true, using: :btree

  create_table "rails_admin_histories", force: true do |t|
    t.text     "message"
    t.string   "username"
    t.integer  "item"
    t.string   "table"
    t.integer  "month",      limit: 2
    t.integer  "year",       limit: 8
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "rails_admin_histories", ["item", "table", "month", "year"], name: "index_rails_admin_histories", using: :btree

  create_table "scores", force: true do |t|
    t.string   "playstyle"
    t.string   "difficulty"
    t.integer  "score"
    t.integer  "player_id"
    t.integer  "music_id"
    t.integer  "season_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "scores", ["music_id"], name: "index_scores_on_music_id", using: :btree
  add_index "scores", ["player_id"], name: "index_scores_on_player_id", using: :btree
  add_index "scores", ["season_id"], name: "index_scores_on_season_id", using: :btree

  create_table "seasons", force: true do |t|
    t.string   "name"
    t.string   "slug"
    t.datetime "start"
    t.datetime "expiry"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "seasons", ["slug"], name: "index_seasons_on_slug", unique: true, using: :btree

  create_table "users", force: true do |t|
    t.string   "email",               default: "", null: false
    t.string   "encrypted_password",  default: "", null: false
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",       default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree

end
