class SeatReservationController < ApplicationController
  def call
    begin
      req = params.permit(:flight_id, :cabin_code, :seat_code, :booking_id)

      raise ActiveRecord::RecordNotFound unless seat_code_valid_for_cabin?(
        req[:flight_id],
        req[:cabin_code],
        req[:seat_code]
      )

      book = Booking.find(req[:booking_id])
      raise Booking::NotPaid.new "You booking is not paid yet."  if book.not.paid?

       Ticket.find(req[:ticket_id])
        .start_confirm_seat!(
          req[:flight_id],
          req[:seat_code],
          user_id = 1
        )

      render json: { message: "Seat #{req[:seat_code]} booked", success: true }, status: :created
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