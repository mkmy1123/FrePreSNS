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

ActiveRecord::Schema.define(version: 2020_06_09_141817) do

  create_table "arguments", force: :cascade do |t|
    t.integer "target", null: false
    t.string "topic", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "checks", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "argument_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["argument_id"], name: "index_checks_on_argument_id"
    t.index ["user_id"], name: "index_checks_on_user_id"
  end

  create_table "components", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "kind_of", null: false
    t.string "title", null: false
    t.text "description", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "entries", force: :cascade do |t|
    t.integer "user_id"
    t.integer "room_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["room_id"], name: "index_entries_on_room_id"
    t.index ["user_id"], name: "index_entries_on_user_id"
  end

  create_table "event_comments", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "event_id", null: false
    t.text "body", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_event_comments_on_event_id"
    t.index ["user_id"], name: "index_event_comments_on_user_id"
  end

  create_table "events", force: :cascade do |t|
    t.string "title", null: false
    t.datetime "start_time"
    t.datetime "end_time"
    t.boolean "all_day", default: false, null: false
    t.text "description"
    t.boolean "is_valid", default: true, null: false
    t.integer "argument_id"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["argument_id"], name: "index_events_on_argument_id"
    t.index ["user_id"], name: "index_events_on_user_id"
  end

  create_table "expressions", force: :cascade do |t|
    t.integer "argument_id", null: false
    t.integer "user_id", null: false
    t.integer "position_of", default: 0
    t.string "statement", null: false
    t.string "detail"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "inquiries", force: :cascade do |t|
    t.string "email"
    t.string "content"
    t.string "problemUrl"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "messages", force: :cascade do |t|
    t.integer "user_id"
    t.integer "room_id"
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["room_id"], name: "index_messages_on_room_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "notifications", force: :cascade do |t|
    t.integer "visitor_id", null: false
    t.integer "visited_id", null: false
    t.integer "argument_id"
    t.integer "expression_id"
    t.integer "event_id"
    t.integer "event_comment_id"
    t.string "action", default: "", null: false
    t.boolean "looked", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["argument_id"], name: "index_notifications_on_argument_id"
    t.index ["event_comment_id"], name: "index_notifications_on_event_comment_id"
    t.index ["event_id"], name: "index_notifications_on_event_id"
    t.index ["expression_id"], name: "index_notifications_on_expression_id"
    t.index ["visited_id"], name: "index_notifications_on_visited_id"
    t.index ["visitor_id"], name: "index_notifications_on_visitor_id"
  end

  create_table "participations", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "event_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_participations_on_event_id"
    t.index ["user_id"], name: "index_participations_on_user_id"
  end

  create_table "relationships", force: :cascade do |t|
    t.integer "user_id"
    t.integer "trust_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["trust_id"], name: "index_relationships_on_trust_id"
    t.index ["user_id", "trust_id"], name: "index_relationships_on_user_id_and_trust_id", unique: true
    t.index ["user_id"], name: "index_relationships_on_user_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "expression_id", null: false
    t.integer "rate", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "rooms", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "taggings", force: :cascade do |t|
    t.integer "tag_id"
    t.string "taggable_type"
    t.integer "taggable_id"
    t.string "tagger_type"
    t.integer "tagger_id"
    t.string "context", limit: 128
    t.datetime "created_at"
    t.index ["context"], name: "index_taggings_on_context"
    t.index ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true
    t.index ["tag_id"], name: "index_taggings_on_tag_id"
    t.index ["taggable_id", "taggable_type", "context"], name: "taggings_taggable_context_idx"
    t.index ["taggable_id", "taggable_type", "tagger_id", "context"], name: "taggings_idy"
    t.index ["taggable_id"], name: "index_taggings_on_taggable_id"
    t.index ["taggable_type"], name: "index_taggings_on_taggable_type"
    t.index ["tagger_id", "tagger_type"], name: "index_taggings_on_tagger_id_and_tagger_type"
    t.index ["tagger_id"], name: "index_taggings_on_tagger_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "taggings_count", default: 0
    t.index ["name"], name: "index_tags_on_name", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "name", default: "", null: false
    t.string "optional_id", default: "", null: false
    t.string "avatar"
    t.text "introduction"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "is_valid", default: true, null: false
    t.index ["optional_id"], name: "index_users_on_optional_id", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
