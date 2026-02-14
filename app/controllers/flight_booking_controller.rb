class FlightBookingController < ApplicationController
  def new
    begin
      flight = Flight.find(
        params[:flight_id]
      )

      raise "invalid flight id" unless flight.open_for_sale?

      Booking.start_booking(
        flight.id,
        passengers(
          params[:passengers]
        ),
        user_id = 1
      )

      render json: { message: "ok" }, status: :created
    rescue => e
      render json: { message: e.message }, status: :bad_request
    end

  end

  def passengers(idx)
    return [] if idx.nil?
    Passenger.available.where(id: idx.map(&:to_i))
  end

end
