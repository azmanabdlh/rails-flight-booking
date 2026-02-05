class CreateFlights < ActiveRecord::Migration[8.0]
  def change
    create_table :flights do |t|
      t.string :flight_code
      t.string :departure_airport
      t.string :arrival_airport
      t.datetime :departure_time
      t.datetime :arrival_time
      t.references :aircraft, null: false, foreign_key: true

      t.timestamps
    end
  end
end
