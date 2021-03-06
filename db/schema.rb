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

ActiveRecord::Schema.define(version: 20181007202105) do

  create_table "applies", force: :cascade do |t|
    t.string "memo"
    t.integer "micropost_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
  end

  create_table "areas", force: :cascade do |t|
    t.string "name"
    t.integer "prefecture_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "messages", force: :cascade do |t|
    t.string "content"
    t.integer "from_id"
    t.integer "to_id"
    t.string "room_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["room_id", "created_at"], name: "index_messages_on_room_id_and_created_at"
  end

  create_table "microposts", force: :cascade do |t|
    t.text "content"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "picture"
    t.date "end_date"
    t.integer "area_id"
    t.boolean "color"
    t.boolean "hair_extension"
    t.integer "prefecture_id"
    t.text "title"
    t.integer "sex"
    t.datetime "start_datetime"
    t.boolean "free_cut"
    t.boolean "transport_cost"
    t.boolean "shampoo"
    t.integer "hair_style"
    t.integer "hair_type"
    t.boolean "use"
    t.boolean "nail"
    t.index ["user_id", "created_at"], name: "index_microposts_on_user_id_and_created_at"
    t.index ["user_id"], name: "index_microposts_on_user_id"
  end

  create_table "post_tags", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "very_short"
    t.boolean "short"
    t.boolean "medium"
    t.boolean "semi_long"
    t.boolean "long"
    t.boolean "straight"
    t.boolean "rather_curly"
    t.boolean "curly"
    t.integer "micropost_id"
    t.integer "sex"
    t.boolean "color"
    t.boolean "cut"
    t.boolean "hair_extension"
    t.boolean "nail"
    t.boolean "shampoo"
    t.boolean "transport_cost"
    t.boolean "mens"
    t.boolean "women"
  end

  create_table "prefectures", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "relationships", force: :cascade do |t|
    t.integer "follower_id"
    t.integer "followed_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["followed_id"], name: "index_relationships_on_followed_id"
    t.index ["follower_id", "followed_id"], name: "index_relationships_on_follower_id_and_followed_id", unique: true
    t.index ["follower_id"], name: "index_relationships_on_follower_id"
  end

  create_table "social_profiles", force: :cascade do |t|
    t.integer "user_id"
    t.string "provider"
    t.string "uid"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_hair_styles", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "very_short"
    t.boolean "short"
    t.boolean "medium"
    t.boolean "semi_long"
    t.boolean "long"
    t.integer "user_id"
  end

  create_table "user_hair_types", force: :cascade do |t|
    t.boolean "straight"
    t.boolean "rather_curly"
    t.boolean "curly"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
    t.string "remember_digest"
    t.string "activation_digest"
    t.boolean "activated", default: false
    t.datetime "activated_at"
    t.string "reset_digest"
    t.datetime "reset_sent_at"
    t.date "birth"
    t.integer "sex"
    t.boolean "color"
    t.boolean "hair_extension"
    t.boolean "nail"
    t.integer "hair_type"
    t.integer "area_id"
    t.integer "prefecture_id"
    t.integer "hair_style"
    t.boolean "staff", default: false
    t.date "last_accessed_at"
    t.string "image"
    t.boolean "fb_sign_up"
    t.boolean "g_sign_up"
    t.boolean "use"
    t.date "qualification"
    t.integer "experience"
    t.boolean "hair_permed"
    t.integer "age"
    t.datetime "deleted_at"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

end
