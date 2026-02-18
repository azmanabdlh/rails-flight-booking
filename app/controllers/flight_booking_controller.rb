class FlightBookingController < ApplicationController
  def new
    begin
      flight = Flight.find(
        params[:flight_id]
      )

      raise "invalid flight id" unless flight.open_for_sale?


      user = User.find(
        params[:user_id] # example, please refer to current auth user
      )

      booking = Booking.start_booking(
        flight.id,
        passengers(
          params[:passengers]
        ),
        user.id
      )

      session = booking.checkout_session! root_url

      render json: { message: "ok", url: session.url }, status: :created
    rescue => e
      render json: { message: e.message, url: "" }, status: :bad_request
    end

  end

  def passengers(idx)
    return [] if idx.blank?
    Passenger.available.where(id: idx.map(&:to_i))
  end

end
