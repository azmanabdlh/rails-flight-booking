class SeatReservationController < ApplicationController
  def call
    begin

      Booking.start_seat_booking!(
        params[:flight_id],
        params[:seat_code],
        resume_session
      )

      render json: { message: "seat #{params[:seat_code]} booked", success: true }, status: :created
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

end
