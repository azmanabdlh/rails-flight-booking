class FlightSeatController < ApplicationController
  def call
    begin

      flight = Flight.find(params[:flight_id])

      raise "invalid flight id" unless flight.open_for_sale?

      render json: { message: "Ok", data: serialize(flight) }, status: :ok
    rescue ActiveRecord::RecordNotFound
      render json: { message: "Seat not found", data: [] }, status: :not_found
    rescue => e
      render json: { message: e.message, data: [] }, status: :bad_request
    end
  end

  private
  def serialize(flight)
    FlightSeatSerializer.new(flight).as_json
  end
end
