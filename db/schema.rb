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

ActiveRecord::Schema.define(:version => 20130223051716) do

  create_table "interests", :force => true do |t|
    t.string   "tag"
    t.integer  "user_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "description"
  end

  create_table "messages", :force => true do |t|
    t.integer  "request_id"
    t.text     "body"
    t.boolean  "sender_viewed"
    t.boolean  "receiver_viewed"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.integer  "user_id"
  end

  create_table "my_skills", :force => true do |t|
    t.string   "tag"
    t.text     "description"
    t.integer  "user_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "requests", :force => true do |t|
    t.integer  "sender_id"
    t.integer  "receiver_id"
    t.boolean  "sender_confirmation"
    t.boolean  "receiver_confirmation"
    t.date     "date"
    t.string   "location"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
    t.string   "title"
    t.time     "start_time"
    t.time     "end_time"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.string   "postal_code"
    t.text     "times"
    t.date     "deadline"
  end

  create_table "reviews", :force => true do |t|
    t.integer  "request_id"
    t.string   "body"
    t.integer  "vote"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "sender_id"
    t.integer  "receiver_id"
  end

  create_table "skills", :force => true do |t|
    t.string   "tag"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.text     "bio"
    t.string   "username"
    t.string   "high_school"
    t.string   "college"
    t.string   "degree"
    t.string   "occupation"
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "zipcode"
    t.string   "city"
    t.string   "state"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
