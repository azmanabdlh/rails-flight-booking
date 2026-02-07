class FlightSeatController < ApplicationController
  def call
    begin

      render json: {
        message: "ok",
        data: serialize(
          Flight.find(
            params[:flight_id]
          )
        )
      }, status: :ok
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
