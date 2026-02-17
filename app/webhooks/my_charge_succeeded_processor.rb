
class MyChargeSucceededProcessor
  def call(event)
    Rails.logger.info "webhook received: #{event.type} ======>"
    booking_id = event.data.object.client_reference_id

    ActiveRecord::Base.transaction do
      booking = Booking.find(booking_id)
      booking.update(phase: "paid")

      # make ticket for passengers
      booking.passengers.each do |passenger|
        Ticket.create(
          booking_id: booking_id,
          flight_id: event.data.object.metadata.flight_id.to_i,
          passenger_id: passenger.id,
          status: "issued",
          issued_at: Time.now
        )
      end
    end
  end
end