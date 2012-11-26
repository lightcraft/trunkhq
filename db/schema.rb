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

ActiveRecord::Schema.define(:version => 20121126222135) do

  create_table "active_calls", :force => true do |t|
    t.string   "uniqueid",            :limit => 32
    t.integer  "channel_id"
    t.integer  "user_id"
    t.integer  "sip_id"
    t.integer  "provider_account_id"
    t.datetime "start_time"
    t.string   "src",                 :limit => 25
    t.string   "dst",                 :limit => 25
    t.integer  "max_duration"
    t.integer  "prefix_group_id"
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
  end

  add_index "active_calls", ["channel_id"], :name => "index_active_calls_on_channel_id"
  add_index "active_calls", ["prefix_group_id"], :name => "index_active_calls_on_prefix_group_id"
  add_index "active_calls", ["provider_account_id"], :name => "index_active_calls_on_provider_account_id"
  add_index "active_calls", ["sip_id"], :name => "index_active_calls_on_sip_id"

  create_table "black_lists", :force => true do |t|
    t.string   "number"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "cdr", :id => false, :force => true do |t|
    t.datetime "calldate",                                                                     :null => false
    t.string   "clid",            :limit => 80,                                :default => "", :null => false
    t.string   "src",             :limit => 80,                                :default => "", :null => false
    t.string   "dst",             :limit => 80,                                :default => "", :null => false
    t.string   "dcontext",        :limit => 80,                                :default => "", :null => false
    t.string   "channel",         :limit => 80,                                :default => "", :null => false
    t.string   "dstchannel",      :limit => 80,                                :default => "", :null => false
    t.string   "lastapp",         :limit => 80,                                :default => "", :null => false
    t.string   "lastdata",        :limit => 80,                                :default => "", :null => false
    t.integer  "duration",                                                     :default => 0,  :null => false
    t.integer  "billsec",                                                      :default => 0,  :null => false
    t.string   "disposition",     :limit => 45,                                :default => "", :null => false
    t.integer  "amaflags",                                                     :default => 0,  :null => false
    t.string   "accountcode",     :limit => 20,                                :default => "", :null => false
    t.string   "userfield",                                                    :default => "", :null => false
    t.string   "hangupcause",     :limit => 50,                                                :null => false
    t.string   "peerip",          :limit => 50,                                                :null => false
    t.string   "recvip",          :limit => 50,                                                :null => false
    t.string   "fromuri",         :limit => 50,                                                :null => false
    t.string   "uri",             :limit => 50,                                                :null => false
    t.string   "useragent",       :limit => 50,                                                :null => false
    t.string   "codec1",          :limit => 50,                                                :null => false
    t.string   "codec2",          :limit => 50,                                                :null => false
    t.string   "llp",             :limit => 50,                                                :null => false
    t.string   "rlp",             :limit => 50,                                                :null => false
    t.string   "ljitt",           :limit => 50,                                                :null => false
    t.string   "rjitt",           :limit => 50,                                                :null => false
    t.string   "uniqueid",        :limit => 32,                                :default => "", :null => false
    t.decimal  "txjitter",                      :precision => 10, :scale => 5
    t.decimal  "rxjitter",                      :precision => 10, :scale => 5
    t.decimal  "rxploss",                       :precision => 10, :scale => 5
    t.decimal  "txploss",                       :precision => 10, :scale => 5
    t.integer  "channel_id"
    t.integer  "user_id"
    t.integer  "prefix_group_id"
  end

  add_index "cdr", ["accountcode"], :name => "accountcode"
  add_index "cdr", ["calldate"], :name => "calldate"
  add_index "cdr", ["dst"], :name => "dst"

  create_table "chan_groups", :force => true do |t|
    t.string  "chan_group_name",     :limit => 50
    t.integer "max_channels_cnt"
    t.integer "max_channels_online"
    t.integer "user_id"
  end

  add_index "chan_groups", ["chan_group_name"], :name => "index_chan_groups_on_chan_group_name", :unique => true

  create_table "chan_prefix_groups", :force => true do |t|
    t.integer "channel_id"
    t.integer "prefix_group_id"
    t.integer "max_minutes_per_day"
    t.integer "max_calls_per_day",   :default => 0
    t.integer "interval_mins"
    t.integer "calls_per_interval"
    t.integer "call_min_interval"
    t.boolean "strict"
    t.boolean "enabled"
  end

  create_table "channels", :force => true do |t|
    t.integer  "sip_id"
    t.integer  "status"
    t.datetime "timeout_expire"
    t.string   "timeout_reason"
    t.integer  "chan_group_id"
    t.integer  "location_id"
    t.date     "init_date"
    t.date     "start_date"
    t.date     "stop_date"
    t.time     "start_time"
    t.time     "stop_time"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name",            :limit => 100
    t.string   "imei",            :limit => 20,  :default => "", :null => false
    t.integer  "friend_group_id"
    t.string   "gsm_number"
  end

  add_index "channels", ["friend_group_id"], :name => "index_channels_on_friend_group_id"

  create_table "codecs", :force => true do |t|
    t.string "codec_name",  :limit => 40
    t.string "description", :limit => 100
  end

  create_table "friend_groups", :force => true do |t|
    t.string   "name"
    t.integer  "user_id"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.integer  "min_duration_sec"
    t.integer  "max_duration_sec"
    t.integer  "calls_per_hour"
  end

  create_table "ivr", :force => true do |t|
    t.string   "number"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "audio"
    t.string   "file_name"
  end

  create_table "locations", :force => true do |t|
    t.string   "name"
    t.integer  "order"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "locations", ["user_id"], :name => "index_locations_on_user_id"

  create_table "prefix_groups", :force => true do |t|
    t.string  "group_name"
    t.decimal "def_rate",            :precision => 10, :scale => 4
    t.decimal "def_init_charge",     :precision => 10, :scale => 4
    t.integer "def_minutes_per_day"
    t.string  "color",                                              :default => "", :null => false
  end

  create_table "prefixes", :force => true do |t|
    t.integer "prefix_group_id"
    t.string  "prefix",          :limit => 200
  end

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "roles", ["name", "resource_type", "resource_id"], :name => "index_roles_on_name_and_resource_type_and_resource_id"
  add_index "roles", ["name"], :name => "index_roles_on_name"

  create_table "sip", :force => true do |t|
    t.integer "user_id",                                                       :null => false
    t.string  "name",             :limit => 80,                                :null => false
    t.string  "host",             :limit => 31,  :default => "dynamic",        :null => false
    t.string  "nat",              :limit => 5,   :default => "yes",            :null => false
    t.string  "type",             :limit => 20,  :default => "friend",         :null => false
    t.string  "accountcode",      :limit => 20
    t.string  "amaflags",         :limit => 13
    t.integer "call-limit",       :limit => 2
    t.string  "callgroup",        :limit => 10
    t.string  "callerid",         :limit => 80
    t.string  "cancallforward",   :limit => 3,   :default => "yes"
    t.string  "canreinvite",      :limit => 3,   :default => "yes"
    t.string  "context",          :limit => 80
    t.string  "defaultip",        :limit => 15
    t.string  "dtmfmode",         :limit => 7
    t.string  "fromuser",         :limit => 80
    t.string  "fromdomain",       :limit => 80
    t.string  "insecure",         :limit => 15
    t.string  "language",         :limit => 2
    t.string  "mailbox",          :limit => 50
    t.string  "md5secret",        :limit => 80
    t.string  "deny",             :limit => 95
    t.string  "permit",           :limit => 95
    t.string  "mask",             :limit => 95
    t.string  "musiconhold",      :limit => 100
    t.string  "pickupgroup",      :limit => 10
    t.string  "qualify",          :limit => 3
    t.string  "regexten",         :limit => 80
    t.string  "restrictcid",      :limit => 25
    t.string  "rtptimeout",       :limit => 3
    t.string  "rtpholdtimeout",   :limit => 3
    t.string  "secret",           :limit => 80
    t.string  "setvar",           :limit => 100
    t.string  "disallow",         :limit => 100, :default => "all"
    t.string  "allow",            :limit => 100, :default => "ulaw;alaw;gsm;"
    t.string  "fullcontact",      :limit => 80,                                :null => false
    t.string  "ipaddr",           :limit => 45,                                :null => false
    t.integer "port",             :limit => 2,   :default => 0,                :null => false
    t.string  "regserver",        :limit => 100
    t.integer "regseconds",                      :default => 0,                :null => false
    t.integer "lastms",                          :default => 0,                :null => false
    t.string  "username",         :limit => 80,                                :null => false
    t.string  "defaultuser",      :limit => 80,                                :null => false
    t.string  "subscribecontext", :limit => 80
    t.string  "useragent",        :limit => 33
    t.string  "authuser",         :limit => 25
    t.integer "commented"
  end

  add_index "sip", ["user_id"], :name => "user_id"

  create_table "sip_conf", :force => true do |t|
    t.integer "cat_metric",                 :default => 0,          :null => false
    t.integer "var_metric",                 :default => 0,          :null => false
    t.string  "filename",    :limit => 128, :default => "sip.conf"
    t.string  "category",    :limit => 128, :default => "general"
    t.string  "var_name",    :limit => 128,                         :null => false
    t.string  "var_val",     :limit => 128,                         :null => false
    t.integer "commented",   :limit => 2,   :default => 0,          :null => false
    t.string  "description"
  end

  add_index "sip_conf", ["id"], :name => "id", :unique => true

  create_table "user_prefix_groups", :force => true do |t|
    t.integer "user_id"
    t.integer "prefix_group_id"
    t.integer "allowed_minutes"
    t.date    "init_date"
    t.string  "rate"
    t.integer "init_charge"
  end

  create_table "users", :force => true do |t|
    t.string   "login",                  :limit => 15
    t.string   "password",               :limit => 15
    t.string   "company",                :limit => 100, :default => "Private"
    t.string   "company_logo",           :limit => 100, :default => "/img/bird.gif"
    t.string   "application_name",       :limit => 100, :default => "Telefony"
    t.datetime "last_login"
    t.string   "email",                  :limit => 60
    t.integer  "role_id"
    t.string   "encrypted_password",                    :default => ""
    t.string   "name",                                  :default => "",              :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.string   "invitation_token",       :limit => 60
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer  "invitation_limit",                      :default => 3,               :null => false
    t.integer  "invited_by_id"
    t.string   "invited_by_type"
    t.boolean  "can_add_friendgroups"
    t.string   "provider_ip_address"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["invitation_token"], :name => "index_users_on_invitation_token"
  add_index "users", ["invited_by_id"], :name => "index_users_on_invited_by_id"
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "users_roles", :id => false, :force => true do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], :name => "index_users_roles_on_user_id_and_role_id"

  create_table "vatson_regmonitor", :id => false, :force => true do |t|
    t.string   "host",           :limit => 200
    t.string   "username",       :limit => 50
    t.string   "status",         :limit => 20
    t.datetime "regtime",                       :null => false
    t.datetime "mail_sent_time",                :null => false
  end

  create_table "vatson_regmonitor_tmp", :id => false, :force => true do |t|
    t.string   "host",           :limit => 200
    t.string   "username",       :limit => 50
    t.string   "status",         :limit => 20
    t.datetime "regtime"
    t.datetime "mail_sent_time",                :null => false
  end

  create_table "vatson_settings", :force => true do |t|
    t.string  "amanager_login",           :limit => 50
    t.string  "amanager_password",        :limit => 50
    t.string  "amanager_host",            :limit => 60
    t.integer "show_sip_reg_in_settings",               :default => 1
    t.integer "show_sip_line_status",                   :default => 0
  end

end
