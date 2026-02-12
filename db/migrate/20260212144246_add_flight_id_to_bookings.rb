class AddFlightIdToBookings < ActiveRecord::Migration[8.0]
  def change
    add_reference :bookings, :flight, null: true, foreign_key: true
  end

  def down
    remove_reference :bookings, :flight
  end
end
