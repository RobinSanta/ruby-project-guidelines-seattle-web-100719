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

ActiveRecord::Schema.define(version: 2019_10_23_183918) do

  create_table "animals", force: :cascade do |t|
    t.string "name"
    t.string "scientific_name"
    t.integer "danger_rating"
    t.string "animal_fact"
    t.boolean "predator"
  end

  create_table "biomes", force: :cascade do |t|
    t.integer "animal_id"
    t.integer "state_id"
  end

  create_table "states", force: :cascade do |t|
    t.string "name"
    t.string "abbr"
  end

end
