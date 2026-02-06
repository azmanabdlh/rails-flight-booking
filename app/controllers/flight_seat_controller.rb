class FlightSeatController < ApplicationController
  def call
    begin
      new_schema(
        Flight.find(
          params(:flight_id)
        )
      )

    rescue ActiveRecord::RecordNotFound
      render json: { message: "Seat not found" }, status: :not_found
    rescue => e
      render json: { message: e.message }, status: :bad_request
    end
  end

  private
  def new_schema(flight)
    Struct.new(
      :flight_code,
      :departure_airport,

    )

    # flight.cabins.map { |cabin|  new_cabin.build(cabin) }
  end

  def

  def new_cabin
    Struct.new(
      :cabin_code,
      :cabin_class,
      :rows,
      :seat_columns,
      :seats
    )
  end
end
