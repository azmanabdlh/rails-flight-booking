class FlightSeatSerializer
  include Alba::Resource

  attributes :flight_code,
    :departure_airport,
    :arrival_airport,
    :departure_time,
    :arrival_time

  many :cabin_layout, resource: FlightCabinSerializer

  many :seat_inventory do
    seats.not_available.map do |seat|
      { seat_code: seat.seat_code, availability_state: seat.availability_state }
    end
  end

  def cabin_layout
    aircraft.cabins
  end
end

