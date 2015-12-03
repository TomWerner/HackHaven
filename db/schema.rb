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

ActiveRecord::Schema.define(version: 20151202035553) do

  create_table "announcements", force: :cascade do |t|
    t.string   "title"
    t.string   "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "contests", force: :cascade do |t|
    t.string   "contestname"
    t.date     "contestdate"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "questions", force: :cascade do |t|
    t.string   "title"
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "contest_id"
  end

  add_index "questions", ["contest_id"], name: "index_questions_on_contest_id"

  create_table "registrations", force: :cascade do |t|
    t.integer  "userid"
    t.string   "contestname"
    t.string   "email"
    t.string   "firstname"
    t.string   "lastname"
    t.string   "year"
    t.string   "major"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "team"
    t.string   "selectedteam"
    t.string   "newteam"
  end

  create_table "submissions", force: :cascade do |t|
    t.integer  "question_id"
    t.integer  "user_id"
    t.string   "code"
    t.integer  "language"
    t.boolean  "correct"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "teams", force: :cascade do |t|
    t.string   "name"
    t.integer  "captain"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "contestname"
  end

  create_table "testcases", force: :cascade do |t|
    t.integer  "question_id"
    t.string   "stdin"
    t.string   "stdout"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "testcases", ["question_id"], name: "index_testcases_on_question_id"

  create_table "users", force: :cascade do |t|
    t.string  "name"
    t.string  "email"
    t.string  "password_hash"
    t.string  "password_salt"
    t.string  "session_token"
    t.integer "admin"
    t.boolean "confirmed"
    t.string  "confirmation_code"
  end

end
