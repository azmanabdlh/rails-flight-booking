class FlightSeatSerializer
  include Alba::Resource


  nested :flight do
    attributes :flight_code,
      :departure_airport,
      :arrival_airport,
      :departure_time,
      :arrival_time


    nested :aircraft do
      attribute :information do |flight|
        { model: flight.aircraft.model, variant: flight.aircraft.variant }
      end

      attribute :available_cabins do |flight|
        flight.aircraft.aircraft_cabins.map do |cabin|
          FlightCabinSerializer.new(cabin).to_h
        end
      end
    end
  end



  nested :flight_seats do
    attribute :unavailable_seats do |flight|
      flight.seats.not_available.map do |seat|
        {
          seat_code: seat.seat_code,
          cabin_code: seat.cabin_code,
          availability_state: seat.availability_state
        }
      end
    end

  end

end
