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

ActiveRecord::Schema.define(:version => 20121215234607) do

  create_table "galleries", :force => true do |t|
    t.string   "name"
    t.string   "slug"
    t.integer  "site_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "galleries", ["site_id"], :name => "index_galleries_on_site_id"

  create_table "gallery_assignments", :force => true do |t|
    t.integer  "gallery_id"
    t.integer  "image_id"
    t.integer  "position",   :default => 1
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "gallery_assignments", ["gallery_id"], :name => "index_gallery_assignments_on_gallery_id"
  add_index "gallery_assignments", ["image_id"], :name => "index_gallery_assignments_on_image_id"

  create_table "images", :force => true do |t|
    t.string   "name"
    t.string   "caption"
    t.string   "image_file"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "site_id"
  end

  add_index "images", ["site_id"], :name => "index_images_on_site_id"

  create_table "sites", :force => true do |t|
    t.string   "name"
    t.string   "slug"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "sites", ["slug"], :name => "index_sites_on_slug", :unique => true
  add_index "sites", ["user_id"], :name => "index_sites_on_user_id"

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
    t.string   "name"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
