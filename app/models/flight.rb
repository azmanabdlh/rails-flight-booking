class Flight < ApplicationRecord
  belongs_to :aircraft

  has_many :seats
  has_many :bookings
  has_many :tickets


  enum :operational_state, {
    open_for_sale: 1,
    closed: 2,
    cancelled: 3
  }

  def seat_code_valid_for_cabin?(cabin_code, seat_code)
    aircraft_cabin = aircraft.aircraft_cabins.find_by(cabin_code: cabin_code)
    return false if aircraft_cabin.nil?

    aircraft_cabin.seat_code_valid_format?(seat_code)
  end

end
