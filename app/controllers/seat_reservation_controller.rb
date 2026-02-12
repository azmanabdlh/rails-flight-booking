class SeatReservationController < ApplicationController
  def call
    begin
      request = params.permit(:flight_id, :cabin_code, :seat_code, :booking_id, :ticket_id)

      raise ActiveRecord::RecordNotFound unless seat_code_valid_for_cabin?(
        request[:flight_id],
        request[:cabin_code],
        request[:seat_code]
      )

      raise Booking::NotPaid unless Booking.find(request[:booking_id]).paid?

       Ticket.find(request[:ticket_id]).start_confirm_seat!(
          request[:flight_id],
          request[:seat_code],
          user_id = 1
        )

      render json: { message: "Seat #{request[:seat_code]} booked", success: true }, status: :created
    rescue ActiveRecord::RecordNotFound
      render json: { message: "Seat not found" }, status: :not_found
    rescue => e
      render json: { message: e.message }, status: :bad_request
    end
  end

  private
  def seat_code_valid_for_cabin?(
    flight_id,
    cabin_code,
    seat_code
  )
    Flight.find(flight_id)
      .seat_code_valid_for_cabin?(seat_code, cabin_code)
  end
end