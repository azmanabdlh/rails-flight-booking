class FlightBookingController < ApplicationController
  def new
    begin
      flight = Flight.find(
        params[:flight_id]
      )

      raise "invalid flight id" unless flight.open_for_sale?

      user_id = params[:user_id] # example, please refer to current auth user

      booking = Booking.start_booking(
        flight.id,
        passengers(
          params[:passengers]
        ),
        user_id
      )

      session = User.find(user_id)
        .create_payment_session(
          booking,
          success_url: root_url
        )

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
