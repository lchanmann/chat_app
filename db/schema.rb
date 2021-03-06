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

ActiveRecord::Schema.define(version: 2018_05_16_005130) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "chatrooms", force: :cascade do |t|
    t.string "title", null: false
    t.bigint "peeps_count", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "conversations", force: :cascade do |t|
    t.bigint "originator_id"
    t.bigint "target_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["originator_id", "target_id"], name: "index_conversations_on_originator_id_and_target_id", unique: true
    t.index ["originator_id"], name: "index_conversations_on_originator_id"
    t.index ["target_id"], name: "index_conversations_on_target_id"
  end

  create_table "messages", force: :cascade do |t|
    t.string "sent_by"
    t.string "content"
    t.bigint "dialogue_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.string "dialogue_type"
    t.index ["dialogue_id", "dialogue_type"], name: "index_messages_on_dialogue_id_and_dialogue_type"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.boolean "is_bot", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_users_on_name", unique: true
  end

  add_foreign_key "conversations", "users", column: "originator_id"
  add_foreign_key "conversations", "users", column: "target_id"
  add_foreign_key "messages", "users"
end
