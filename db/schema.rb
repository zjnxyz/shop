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

ActiveRecord::Schema.define(:version => 20130314013035) do

  create_table "applications", :force => true do |t|
    t.integer  "sell_id"
    t.integer  "user_id"
    t.integer  "staff_id"
    t.integer  "type"
    t.text     "remark"
    t.boolean  "is_handle"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "app_type"
  end

  add_index "applications", ["sell_id"], :name => "index_applications_on_sell_id"
  add_index "applications", ["staff_id"], :name => "index_applications_on_staff_id"
  add_index "applications", ["user_id"], :name => "index_applications_on_user_id"

  create_table "brands", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "imgurl"
  end

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "imgurl"
  end

  create_table "images", :force => true do |t|
    t.string   "img_url"
    t.integer  "product_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "images", ["product_id"], :name => "index_images_on_product_id"

  create_table "members", :force => true do |t|
    t.string   "name"
    t.float    "discount"
    t.float    "conversion_rate"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "orders", :force => true do |t|
    t.integer  "amount"
    t.float    "sum"
    t.text     "remark"
    t.integer  "product_id"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.float    "actual_sum"
    t.datetime "end_time"
  end

  add_index "orders", ["product_id"], :name => "index_orders_on_product_id"
  add_index "orders", ["user_id"], :name => "index_orders_on_user_id"

  create_table "photos", :force => true do |t|
    t.string   "image"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "products", :force => true do |t|
    t.string   "name"
    t.string   "number"
    t.float    "purchase_price"
    t.float    "sell_price"
    t.integer  "stock_quantity"
    t.boolean  "status"
    t.boolean  "is_percentage"
    t.float    "percentage_price"
    t.float    "over_royalty_percentage"
    t.boolean  "is_rural_areas"
    t.float    "subsidies_proportion"
    t.string   "pinyin_initials"
    t.integer  "stock_lower_limit"
    t.string   "img_url"
    t.text     "summary"
    t.integer  "unit_id"
    t.integer  "category_id"
    t.integer  "brand_id"
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
    t.integer  "sales_volume"
    t.string   "big_imgurl"
    t.float    "discount"
    t.text     "body_html"
    t.string   "photo_url"
  end

  add_index "products", ["brand_id"], :name => "index_products_on_brand_id"
  add_index "products", ["category_id"], :name => "index_products_on_category_id"
  add_index "products", ["unit_id"], :name => "index_products_on_unit_id"

  create_table "repurchases", :force => true do |t|
    t.integer  "amount"
    t.float    "sum"
    t.float    "actual_sum"
    t.text     "remark"
    t.integer  "sell_id"
    t.integer  "staff_id"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.boolean  "status"
  end

  add_index "repurchases", ["sell_id"], :name => "index_repurchases_on_sell_id"
  add_index "repurchases", ["staff_id"], :name => "index_repurchases_on_staff_id"
  add_index "repurchases", ["user_id"], :name => "index_repurchases_on_user_id"

  create_table "sells", :force => true do |t|
    t.integer  "amount"
    t.float    "actual_sum"
    t.float    "sum"
    t.text     "remark"
    t.integer  "user_id"
    t.integer  "staff_id"
    t.integer  "product_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.float    "real_discount"
    t.integer  "use_integral"
    t.boolean  "status"
  end

  add_index "sells", ["product_id"], :name => "index_sells_on_product_id"
  add_index "sells", ["staff_id"], :name => "index_sells_on_staff_id"
  add_index "sells", ["user_id"], :name => "index_sells_on_user_id"

  create_table "staffs", :force => true do |t|
    t.integer  "number"
    t.string   "name"
    t.string   "pinyin_initials"
    t.integer  "sex"
    t.datetime "birthday"
    t.string   "card_id"
    t.string   "address"
    t.integer  "phone"
    t.string   "email"
    t.datetime "start_work_time"
    t.float    "low_salary"
    t.string   "img_url"
    t.float    "allowance"
    t.text     "remark"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.integer  "type"
    t.string   "hash_password"
    t.string   "salt"
    t.integer  "staff_type"
    t.string   "pic"
  end

  create_table "units", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.integer  "number"
    t.string   "name"
    t.integer  "phone"
    t.string   "email"
    t.string   "pinyin_initials"
    t.integer  "member_id"
    t.integer  "integral"
    t.text     "remark"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "hash_password"
    t.string   "salt"
    t.string   "username"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["member_id"], :name => "index_users_on_member_id"
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
