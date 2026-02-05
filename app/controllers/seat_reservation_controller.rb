class SeatReservationController < ApplicationController
  def call
    req = flight_params
    flight = Flight.find(req[:flight_id])

    unless flight.seat_available?(req[:seat_code])
      render json: { message: "seat not available", success: false }, status: :bad_request
    end

    # .....

  end

  private
  def flight_params
    params.permit(:flight_id, :seat_code)
  end
end
