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

ActiveRecord::Schema.define(version: 20171216070323) do

  create_table "users", force: :cascade do |t|
    t.string "mobile"
    t.string "password_digest"
    t.string "nickname"
    t.string "weixin_id"
    t.integer "gender", default: 2
    t.date "birthday"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["mobile"], name: "index_users_on_mobile", unique: true
    t.index ["nickname"], name: "index_users_on_nickname", unique: true
    t.index ["weixin_id"], name: "index_users_on_weixin_id", unique: true
  end

end
