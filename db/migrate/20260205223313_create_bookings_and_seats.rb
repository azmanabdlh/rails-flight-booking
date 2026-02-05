class CreateBookingsAndSeats < ActiveRecord::Migration[8.0]
  def change
    create_table :bookings_seats, id: false do |t|
      t.belongs_to :booking, null: false, foreign_key: true
      t.belongs_to :seat, null: false, foreign_key: true

      t.timestamps
    end
  end
end
