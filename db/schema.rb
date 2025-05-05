# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2025_05_05_145815) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "content_availabilities", force: :cascade do |t|
    t.string "url"
    t.bigint "content_id", null: false
    t.bigint "streaming_app_id", null: false
    t.bigint "country_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["content_id"], name: "index_content_availabilities_on_content_id"
    t.index ["country_id"], name: "index_content_availabilities_on_country_id"
    t.index ["streaming_app_id"], name: "index_content_availabilities_on_streaming_app_id"
  end

  create_table "content_schedules", force: :cascade do |t|
    t.bigint "content_id", null: false
    t.datetime "start_time", null: false
    t.datetime "end_time", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["content_id"], name: "index_content_schedules_on_content_id"
  end

  create_table "contents", force: :cascade do |t|
    t.string "type", null: false
    t.string "title"
    t.integer "year"
    t.integer "duration_in_seconds"
    t.integer "number"
    t.bigint "parent_content_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["parent_content_id"], name: "index_contents_on_parent_content_id"
    t.index ["title"], name: "index_contents_on_title"
    t.index ["year"], name: "index_contents_on_year"
  end

  create_table "countries", force: :cascade do |t|
    t.string "name", null: false
    t.string "code", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "index_countries_on_code", unique: true
    t.index ["name"], name: "index_countries_on_name", unique: true
  end

  create_table "streaming_apps", force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_streaming_apps_on_name", unique: true
  end

  create_table "user_apps", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "streaming_app_id", null: false
    t.integer "position", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["streaming_app_id"], name: "index_user_apps_on_streaming_app_id"
    t.index ["user_id"], name: "index_user_apps_on_user_id"
  end

  create_table "user_channel_programs", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "channel_program_id", null: false
    t.bigint "time_watched_in_seconds", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["channel_program_id"], name: "index_user_channel_programs_on_channel_program_id"
    t.index ["user_id", "channel_program_id"], name: "index_user_channel_programs_on_user_id_and_channel_program_id", unique: true
    t.index ["user_id"], name: "index_user_channel_programs_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "lower((email)::text)", name: "index_users_on_lower_email", unique: true
  end

  add_foreign_key "content_availabilities", "contents"
  add_foreign_key "content_availabilities", "countries"
  add_foreign_key "content_availabilities", "streaming_apps"
  add_foreign_key "content_schedules", "contents"
  add_foreign_key "contents", "contents", column: "parent_content_id"
  add_foreign_key "user_apps", "streaming_apps"
  add_foreign_key "user_apps", "users"
  add_foreign_key "user_channel_programs", "contents", column: "channel_program_id"
  add_foreign_key "user_channel_programs", "users"
end
