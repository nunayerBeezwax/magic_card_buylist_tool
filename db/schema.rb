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

ActiveRecord::Schema.define(version: 20140705235257) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "buycards", force: true do |t|
    t.string  "set"
    t.string  "name"
    t.boolean "foil"
    t.boolean "played"
    t.float   "price"
    t.integer "quantity"
  end

  create_table "cards", force: true do |t|
    t.string  "set"
    t.string  "name"
    t.string  "rarity"
    t.string  "condition"
    t.float   "price"
    t.integer "quantity"
    t.boolean "foil"
  end

  create_table "hits", force: true do |t|
    t.integer "card_id"
    t.integer "buycard_id"
    t.integer "quantity"
    t.float   "price"
  end

  create_table "sales", force: true do |t|
    t.string  "name"
    t.string  "set"
    t.integer "quantity"
    t.float   "price"
    t.boolean "played"
    t.boolean "foil"
  end

end
