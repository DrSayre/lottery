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

ActiveRecord::Schema.define(version: 20160116191812) do

  create_table "drawing_times", force: :cascade do |t|
    t.text     "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pick_threes", force: :cascade do |t|
    t.integer  "first_number"
    t.integer  "second_number"
    t.integer  "third_number"
    t.date     "drawing_date"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "state_id"
    t.integer  "drawing_time_id"
    t.index ["drawing_time_id"], name: "index_pick_threes_on_drawing_time_id"
    t.index ["state_id"], name: "index_pick_threes_on_state_id"
  end

  create_table "states", force: :cascade do |t|
    t.text     "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
