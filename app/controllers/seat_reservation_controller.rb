class SeatReservationController < ApplicationController
  def call
    begin

      Booking.mark_seat_book(
        params[:flight_id],
        params[:seat_code],
        resume_session
      )

      render json: { message: "seat #{params[:seat_code]} booked", success: true }, status: :created
    rescue => e
      render json: { message: e.message, success: false }, status: :bad_request
    end
  end

end
