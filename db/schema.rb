# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20091202190118) do

  create_table "baby_names", :force => true do |t|
    t.string   "name"
    t.string   "gender"
    t.string   "year"
    t.integer  "hispanic_count", :default => 0
    t.integer  "hispanic_rank",  :default => 0
    t.integer  "white_count",    :default => 0
    t.integer  "white_rank",     :default => 0
    t.integer  "asian_count",    :default => 0
    t.integer  "asian_rank",     :default => 0
    t.integer  "black_count",    :default => 0
    t.integer  "black_rank",     :default => 0
    t.integer  "unknown_count",  :default => 0
    t.integer  "unknown_rank",   :default => 0
    t.integer  "total_count",    :default => 0
    t.integer  "total_rank",     :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "baby_names", ["gender"], :name => "index_baby_names_on_gender"
  add_index "baby_names", ["name"], :name => "index_baby_names_on_name"
  add_index "baby_names", ["year"], :name => "index_baby_names_on_year"

end
