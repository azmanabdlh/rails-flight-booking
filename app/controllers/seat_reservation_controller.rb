class SeatReservationController < ApplicationController
  def call
    begin

      raise ActiveRecord::RecordNotFound unless seat_code_valid_for_cabin?(
        params[:flight_id],
        params[:cabin_code],
        params[:seat_code]
      )

      Booking.start_seat_booking!(
        params[:flight_id],
        params[:seat_code],
        1
      )

      render json: { message: "Seat #{params[:seat_code]} booked", success: true }, status: :created
    rescue ActiveRecord::RecordNotFound
      render json: { message: "Seat not found" }, status: :not_found
    rescue Booking::SeatUnavailable
      render json: { message: "Seat unavailable" }, status: :bad_request
    rescue Booking::SeatAlreadyBooked
      render json: { message: "Seat already booked" }, status: :bad_request
    rescue => e
      render json: { message: e.message }, status: :bad_request
    end
  end

  def seat_code_valid_for_cabin?(
    flight_id,
    cabin_code,
    seat_code
  )

    Flight.find(flight_id)
      .seat_code_valid_for_cabin?(seat_code, cabin_code)
  end
end
