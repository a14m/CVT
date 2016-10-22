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

ActiveRecord::Schema.define(version: 20161022041841) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "torrents", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string   "name"
    t.integer  "transmission_id"
    t.bigint   "size"
    t.string   "checksum"
    t.uuid     "user_id"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.string   "torrent_file_name"
    t.string   "torrent_content_type"
    t.integer  "torrent_file_size"
    t.datetime "torrent_updated_at"
    t.index ["user_id"], name: "index_torrents_on_user_id", using: :btree
  end

  create_table "users", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string   "email",                                                null: false
    t.string   "crypted_password"
    t.string   "salt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_me_token"
    t.datetime "remember_me_token_expires_at"
    t.string   "reset_password_token"
    t.datetime "reset_password_token_expires_at"
    t.datetime "reset_password_email_sent_at"
    t.string   "stripe_id"
    t.datetime "expires_at",                                           null: false
    t.bigint   "quota",                           default: 5368709120
    t.string   "subscription_id"
    t.datetime "canceled_at"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["remember_me_token"], name: "index_users_on_remember_me_token", using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", using: :btree
    t.index ["stripe_id"], name: "index_users_on_stripe_id", using: :btree
    t.index ["subscription_id"], name: "index_users_on_subscription_id", using: :btree
  end

end
