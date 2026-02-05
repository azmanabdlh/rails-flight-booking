class CreateBookings < ActiveRecord::Migration[8.0]
  def change
    create_table :bookings do |t|
      t.string :booking_code
      t.references :user, null: false, foreign_key: true
      t.integer :phase
      t.datetime :expired_at

      t.timestamps
    end
  end
end
