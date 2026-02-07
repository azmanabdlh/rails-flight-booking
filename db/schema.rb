# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2026_02_07_142728) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "aircraft_cabins", force: :cascade do |t|
    t.bigint "aircraft_id", null: false
    t.string "cabin_code"
    t.integer "row_start"
    t.integer "row_end"
    t.jsonb "row_features"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "seat_columns", default: [], null: false, array: true
    t.string "aisle_columns", default: [], null: false, array: true
    t.index ["aircraft_id"], name: "index_aircraft_cabins_on_aircraft_id"
  end

  create_table "aircrafts", force: :cascade do |t|
    t.string "manufacturer"
    t.string "model"
    t.string "variant"
    t.integer "manufacture_year"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "bookings", force: :cascade do |t|
    t.string "booking_code"
    t.bigint "user_id", null: false
    t.integer "phase"
    t.datetime "expired_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_bookings_on_user_id"
  end

  create_table "bookings_seats", id: false, force: :cascade do |t|
    t.bigint "booking_id", null: false
    t.bigint "seat_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["booking_id"], name: "index_bookings_seats_on_booking_id"
    t.index ["seat_id"], name: "index_bookings_seats_on_seat_id"
  end

  create_table "flights", force: :cascade do |t|
    t.string "flight_code"
    t.string "departure_airport"
    t.string "arrival_airport"
    t.datetime "departure_time"
    t.datetime "arrival_time"
    t.bigint "aircraft_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "operational_state"
    t.index ["aircraft_id"], name: "index_flights_on_aircraft_id"
  end

  create_table "seats", force: :cascade do |t|
    t.bigint "flight_id", null: false
    t.string "seat_code"
    t.string "availability_state", default: "AVAILABLE"
    t.datetime "locked_until"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "cabin_code"
    t.index ["flight_id"], name: "index_seats_on_flight_id"
  end

  create_table "tickets", force: :cascade do |t|
    t.bigint "booking_id", null: false
    t.bigint "flight_id", null: false
    t.string "passenger_id"
    t.datetime "issued_at"
    t.string "seat_code"
    t.integer "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["booking_id"], name: "index_tickets_on_booking_id"
    t.index ["flight_id"], name: "index_tickets_on_flight_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "aircraft_cabins", "aircrafts"
  add_foreign_key "bookings", "users"
  add_foreign_key "bookings_seats", "bookings"
  add_foreign_key "bookings_seats", "seats"
  add_foreign_key "flights", "aircrafts"
  add_foreign_key "seats", "flights"
  add_foreign_key "tickets", "bookings"
  add_foreign_key "tickets", "flights"
end
