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

ActiveRecord::Schema.define(:version => 20130225164823) do

  create_table "elements", :force => true do |t|
    t.integer  "parent_id"
    t.integer  "position",         :default => 0
    t.string   "child_type"
    t.integer  "child_id"
    t.integer  "page_id"
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
    t.integer  "width",            :default => 300
    t.integer  "height",           :default => 300
    t.integer  "left",             :default => 0
    t.integer  "top",              :default => 0
    t.integer  "z_index",          :default => 0
    t.integer  "image_width",      :default => 200
    t.integer  "image_height",     :default => 200
    t.integer  "image_top",        :default => 0
    t.integer  "image_left",       :default => 0
    t.integer  "header_id"
    t.integer  "elementable_id"
    t.string   "elementable_type"
  end

  add_index "elements", ["child_id", "child_type", "page_id"], :name => "element_index", :unique => true
  add_index "elements", ["header_id"], :name => "index_elements_on_header_id"

  create_table "folders", :force => true do |t|
    t.string   "name"
    t.integer  "site_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "galleries", :force => true do |t|
    t.string   "name"
    t.string   "slug"
    t.integer  "site_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.integer  "gallery_page_id"
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

  create_table "gallery_pages", :force => true do |t|
    t.string   "name"
    t.integer  "site_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "gallery_pages", ["site_id"], :name => "index_gallery_pages_on_site_id"

  create_table "headers", :force => true do |t|
    t.integer  "site_id"
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "homepages", :force => true do |t|
    t.string   "name",       :default => "Home"
    t.integer  "site_id"
    t.string   "slug"
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
  end

  add_index "homepages", ["site_id"], :name => "index_homepages_on_site_id"

  create_table "images", :force => true do |t|
    t.string   "name"
    t.string   "caption"
    t.string   "image_file"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "site_id"
  end

  add_index "images", ["site_id"], :name => "index_images_on_site_id"

  create_table "links", :force => true do |t|
    t.string   "name"
    t.string   "url"
    t.integer  "site_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "links", ["site_id"], :name => "index_links_on_site_id"

  create_table "nav_items", :force => true do |t|
    t.integer  "site_id"
    t.string   "navable_type"
    t.integer  "navable_id"
    t.integer  "position",     :default => 0
    t.integer  "parent_id"
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
    t.boolean  "nav"
  end

  add_index "nav_items", ["navable_id", "navable_type", "site_id"], :name => "index_nav_items_on_navable_id_and_navable_type_and_site_id"

  create_table "page_texts", :force => true do |t|
    t.text     "content"
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
    t.text     "style",      :default => ""
  end

  create_table "pages", :force => true do |t|
    t.string   "name"
    t.integer  "site_id"
    t.string   "slug"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "settings", :force => true do |t|
    t.integer  "site_id"
    t.string   "title"
    t.text     "meta_description"
    t.text     "meta_keywords"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "site_templates", :force => true do |t|
    t.integer  "site_id"
    t.integer  "template_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "sites", :force => true do |t|
    t.string   "name"
    t.string   "slug"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "sites", ["slug"], :name => "index_sites_on_slug", :unique => true
  add_index "sites", ["user_id"], :name => "index_sites_on_user_id"

  create_table "templates", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "image_url"
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
    t.string   "name"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
