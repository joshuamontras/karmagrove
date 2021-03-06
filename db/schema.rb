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

ActiveRecord::Schema.define(:version => 20141204233329) do

  create_table "active_admin_comments", :force => true do |t|
    t.string   "resource_id",   :null => false
    t.string   "resource_type", :null => false
    t.integer  "author_id"
    t.string   "author_type"
    t.text     "body"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "namespace"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], :name => "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], :name => "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], :name => "index_admin_notes_on_resource_type_and_resource_id"

  create_table "admin_users", :force => true do |t|
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
  end

  add_index "admin_users", ["email"], :name => "index_admin_users_on_email", :unique => true
  add_index "admin_users", ["reset_password_token"], :name => "index_admin_users_on_reset_password_token", :unique => true

  create_table "auction_items", :force => true do |t|
    t.string   "name"
    t.string   "image_url"
    t.text     "description"
    t.integer  "starting_price"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "auctions", :force => true do |t|
    t.datetime "start_date"
    t.datetime "end_date"
    t.integer  "market_id"
    t.integer  "seller_id"
    t.integer  "buyer_id"
    t.integer  "auction_item_id"
    t.boolean  "buy_now"
    t.boolean  "published"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "auctions", ["auction_item_id"], :name => "index_auctions_on_auction_item_id"
  add_index "auctions", ["buyer_id"], :name => "index_auctions_on_buyer_id"
  add_index "auctions", ["market_id"], :name => "index_auctions_on_market_id"
  add_index "auctions", ["seller_id"], :name => "index_auctions_on_seller_id"

  create_table "batch_charities", :force => true do |t|
    t.integer  "batch_id"
    t.integer  "charity_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "batch_charity_payments", :force => true do |t|
    t.integer  "batch_id"
    t.integer  "charity_payment_id"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  add_index "batch_charity_payments", ["batch_id"], :name => "index_batch_charity_payments_on_batch_id"
  add_index "batch_charity_payments", ["charity_payment_id"], :name => "index_batch_charity_payments_on_charity_payment_id"

  create_table "batch_products", :force => true do |t|
    t.integer  "batch_id"
    t.integer  "product_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "batch_products", ["batch_id"], :name => "index_batch_products_on_batch_id"
  add_index "batch_products", ["product_id"], :name => "index_batch_products_on_product_id"

  create_table "batch_users", :force => true do |t|
    t.integer  "user_id_id"
    t.integer  "batch_id_id"
    t.string   "user_type"
    t.float    "weight"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "batches", :force => true do |t|
    t.string   "batch_name"
    t.float    "sales"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "state"
  end

  create_table "bids", :force => true do |t|
    t.integer  "auction_id"
    t.integer  "amount"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "bids", ["auction_id"], :name => "index_bids_on_auction_id"

  create_table "buddhas", :force => true do |t|
    t.integer  "product_id"
    t.string   "file_location"
    t.string   "media_type"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "charities", :force => true do |t|
    t.integer  "ein"
    t.string   "legal_name"
    t.string   "city"
    t.string   "state"
    t.string   "deductibility_status"
    t.string   "country"
    t.string   "deductibility_status_description"
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
    t.string   "uri"
  end

  create_table "charity_payments", :force => true do |t|
    t.integer  "payment_reference"
    t.string   "payment_provider"
    t.integer  "charity_id"
    t.string   "state"
    t.integer  "amount"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  add_index "charity_payments", ["charity_id"], :name => "index_charity_payments_on_charity_id"

  create_table "donations", :force => true do |t|
    t.integer  "purchase_id"
    t.integer  "charity_id"
    t.decimal  "amount",        :precision => 8, :scale => 2
    t.datetime "created_at",                                  :null => false
    t.datetime "updated_at",                                  :null => false
    t.date     "donation_date"
  end

  add_index "donations", ["charity_id"], :name => "index_donations_on_charity_id"
  add_index "donations", ["purchase_id"], :name => "index_donations_on_purchase_id"

  create_table "markets", :force => true do |t|
    t.string   "country"
    t.string   "state"
    t.string   "county"
    t.string   "district"
    t.string   "intersection"
    t.string   "address"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "product_charities", :force => true do |t|
    t.integer  "product_id"
    t.integer  "charity_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "product_charities", ["charity_id"], :name => "index_product_charities_on_charity_id"
  add_index "product_charities", ["product_id"], :name => "index_product_charities_on_product_id"

  create_table "products", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.decimal  "price"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "image_url"
  end

  create_table "purchases", :force => true do |t|
    t.integer  "product_id"
    t.integer  "buyer_id"
    t.integer  "seller_id"
    t.integer  "donation_id"
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
    t.string   "state"
    t.string   "stripe_customer_token"
    t.string   "stripe_transaction_id"
    t.integer  "retailer_id"
    t.integer  "batch_id"
    t.float    "purchase_price"
    t.float    "cost"
    t.integer  "revenue_donation_percent"
    t.integer  "profit_donation_percent"
  end

  add_index "purchases", ["buyer_id"], :name => "index_purchases_on_buyer_id"
  add_index "purchases", ["donation_id"], :name => "index_purchases_on_donation_id"
  add_index "purchases", ["product_id"], :name => "index_purchases_on_product_id"
  add_index "purchases", ["seller_id"], :name => "index_purchases_on_seller_id"

  create_table "retailers", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.string   "address"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
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
    t.string   "username"
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.integer  "facebook_id"
    t.boolean  "email_subscriber"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
