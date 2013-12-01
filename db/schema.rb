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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 15) do

  create_table "accounts", :force => true do |t|
    t.string   "name"
    t.string   "surname"
    t.string   "email"
    t.string   "crypted_password"
    t.string   "role"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "machines", :force => true do |t|
    t.string   "name"
    t.text     "difficulties"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.string   "playstyles"
    t.string   "slug"
  end

  create_table "musics", :force => true do |t|
    t.string   "name"
    t.integer  "machine_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "artist"
    t.string   "season"
  end

  create_table "players", :force => true do |t|
    t.string   "name",        :null => false
    t.string   "screen_name"
    t.string   "password",    :null => false
    t.string   "twitter_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "players", ["name"], :name => "index_players_on_name", :unique => true

  create_table "posts", :force => true do |t|
    t.string   "title"
    t.text     "body"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "scores", :force => true do |t|
    t.string   "season"
    t.string   "difficulty"
    t.float    "score"
    t.integer  "player_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "playstyle"
    t.integer  "music_id"
  end

  create_table "seasons", :force => true do |t|
    t.string   "name"
    t.date     "start"
    t.date     "end"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
