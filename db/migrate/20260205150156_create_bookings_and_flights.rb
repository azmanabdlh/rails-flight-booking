class CreateBookingsAndFlights < ActiveRecord::Migration[8.0]
  def change
    create_table :bookings_flights, id: false do |t|
      t.belongs_to :booking, null: false, foreign_key: true
      t.belongs_to :flight, null: false, foreign_key: true


      t.timestamps
    end
  end
end
