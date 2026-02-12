class FlightBookingController < ApplicationController
  def new
    flight = Flight.find(params[:flight_id])
    return render json: { message: "invalid flight id" }, status: :bad_request  unless flight.open_for_sale?

    Booking.start_booking(
      flight.id,
      params[:flight_id],
      user_id = 1
    )

    render json: { message: "ok" }, status: :created
  end
end
