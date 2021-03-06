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

ActiveRecord::Schema.define(version: 20180401172645) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "activity_events", force: :cascade do |t|
    t.bigint "company_id"
    t.integer "driver_id"
    t.datetime "timestamp"
    t.float "latitude"
    t.float "longitude"
    t.float "accuracy"
    t.float "speed"
    t.string "activity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_activity_events_on_company_id"
    t.index ["driver_id", "timestamp"], name: "index_activity_events_on_driver_id_and_timestamp"
  end

  create_table "companies", force: :cascade do |t|
    t.json "field"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "activity_events", "companies"
end
