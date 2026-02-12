class SeatReservationController < ApplicationController
  def call
    begin
      raise ActiveRecord::RecordNotFound unless seat_code_valid_for_cabin?(
        params[:flight_id],
        params[:cabin_code],
        params[:seat_code]
      )


       seat_assignment(
          params[:ticket_id],
          params[:flight_id],
          params[:seat_code],
          user_id = 1
        )

      render json: { message: "Seat #{params[:seat_code]} booked", success: true }, status: :created
    rescue ActiveRecord::RecordNotFound
      render json: { message: "Seat not found" }, status: :not_found
    rescue => e
      render json: { message: e.message }, status: :bad_request
    end
  end

  private

  def seat_assignment(ticket_id, flight_id, seat_code, user_id)
    Ticket.find(ticket_id).start_confirm_seat!(
      flight_id,
      seat_code,
      user_id
    )
  end

  def seat_code_valid_for_cabin?(flight_id, cabin_code, seat_code)
    Flight.find(flight_id)
      .seat_code_valid_for_cabin?(seat_code, cabin_code)
  end
end