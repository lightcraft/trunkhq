class InitAsterisk < ActiveRecord::Migration
  def up

    create_table "chan_groups", :force => true do |t|
      t.string  "chan_group_name",     :limit => 50
      t.integer "max_channels_cnt"
      t.integer "max_channels_online"
    end

    create_table "chan_prefix_groups", :force => true do |t|
      t.integer "channel_id"
      t.integer "prefix_group_id"
      t.integer "max_minutes_per_day"
    end

    create_table "channels", :force => true do |t|
      t.integer "sip_id"
      t.integer "interval_mins"
      t.integer "calls_per_interval"
      t.integer "call_min_interval"
      t.integer "status"
      t.integer "chan_group_id"
    end

    create_table "codecs", :force => true do |t|
      t.string "codec_name",  :limit => 40
      t.string "description", :limit => 100
    end

    create_table "prefix_groups", :force => true do |t|
      t.string  "group_name"
      t.decimal "rate",            :precision => 10, :scale => 4
      t.decimal "init_charge",     :precision => 10, :scale => 4
      t.integer "minutes_per_day"
    end

    create_table "prefixes", :force => true do |t|
      t.integer "prefix_group_id"
      t.string  "prefix",          :limit => 200
    end

    create_table "sip", :force => true do |t|
      t.integer "user_id",                                                       :null => false
      t.string  "name",             :limit => 80,                                :null => false
      t.string  "host",             :limit => 31,  :default => "dynamic",        :null => false
      t.string  "nat",              :limit => 5,   :default => "yes",            :null => false
      t.string  "type",             :limit => 20,   :default => "friend",         :null => false
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
      t.integer "max_minutes_per_day"
      t.decimal "rate",                :precision => 10, :scale => 4
    end

    create_table "user_rates", :force => true do |t|
      t.integer "prefix_group_id"
      t.decimal "rate",                :precision => 10, :scale => 2
      t.integer "sample_interval_sec"
    end

    create_table "users", :force => true do |t|
      t.string   "login",            :limit => 15
      t.string   "password",         :limit => 15
      t.string   "company",          :limit => 100, :default => "Private"
      t.string   "company_logo",     :limit => 100, :default => "/img/bird.gif"
      t.string   "application_name", :limit => 100, :default => "Telefony"
      t.datetime "last_login"
      t.string   "email",            :limit => 60
      t.integer  "role_id"
    end

    create_table "vatson_regmonitor", :id => false, :force => true do |t|
      t.string    "host",           :limit => 200
      t.string    "username",       :limit => 50
      t.string    "status",         :limit => 20
      t.timestamp "regtime",                       :null => false
      t.timestamp "mail_sent_time",                :null => false
    end

    create_table "vatson_regmonitor_tmp", :id => false, :force => true do |t|
      t.string    "host",           :limit => 200
      t.string    "username",       :limit => 50
      t.string    "status",         :limit => 20
      t.timestamp "regtime"
      t.timestamp "mail_sent_time",                :null => false
    end

    create_table "vatson_settings", :force => true do |t|
      t.string  "amanager_login",           :limit => 50
      t.string  "amanager_password",        :limit => 50
      t.string  "amanager_host",            :limit => 60
      t.integer "show_sip_reg_in_settings",               :default => 1
      t.integer "show_sip_line_status",                   :default => 0
    end
  end

  def down
  end
end
