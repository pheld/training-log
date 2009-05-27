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

ActiveRecord::Schema.define(:version => 20090527050922) do

  create_table "activities", :force => true do |t|
    t.integer  "user_id"
    t.integer  "activity_type_id"
    t.date     "date"
    t.text     "description"
    t.float    "duration_hours"
    t.float    "distance_miles"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "activity_types", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "climbs", :force => true do |t|
    t.text     "description"
    t.integer  "duration_seconds"
    t.integer  "altitude_gained_feet"
    t.float    "weight_pounds"
    t.float    "weight_of_equipment_pounds"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "activity_id"
  end

  create_table "fitness_samples", :force => true do |t|
    t.integer  "user_id"
    t.date     "date"
    t.float    "weight_pounds"
    t.float    "body_fat_percentage"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "login"
    t.string   "password"
    t.boolean  "is_admin"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
