class FlightSeatSerializer
  include Alba::Resource

  attributes :flight_code,
    :departure_airport,
    :arrival_airport,
    :departure_time,
    :arrival_time

  many :cabins, resource: FlightCabinSerializer

  attribute :seat_inventory do |flight|
    flight.seats.not_available.map do |seat|
      { seat_code: seat.seat_code, cabin_code: seat.cabin_code, availability_state: seat.availability_state }
    end
  end


end
