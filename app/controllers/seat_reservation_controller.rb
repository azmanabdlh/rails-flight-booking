class SeatReservationController < ApplicationController
  def call
    flight = Flight.find(params[:flight_id])
    seat_code = params[:seat_code]

    unless flight.seat_available?(seat_code)
      render json: { message: "seat not available", success: false }, status: :bad_request
    end

    Booking.mark_seat_book(
      resume_session
    )

    render json: { message: "seat #{seat_code} booked", success: true }, status: :ok
  end

end
