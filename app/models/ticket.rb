class Ticket < ApplicationRecord
  belongs_to :booking
  belongs_to :flight
  belongs_to :passenger


  enum :status, {
    issued: 1,
    boarding: 2,
    departed: 3,
    arrived: 4
  }

  def self.seat_available?(flight_id, seat_code)
    lock.find_by(flight_id: flight_id, seat_code: seat_code).nil?
  end

  def start_confirm_seat!(
    flight_id,
    pax_id,
    seat_code
  )
    transaction do
      return nil if seat_assigned?(pax_id)

      raise Booking::Exception::InvalidPassenger unless booking.allowed_passenger?(pax_id)
      raise Booking::Exception::NotPaid unless booking.paid?

      raise SeatUnavailable unless Ticket.seat_available?(flight_id, seat_code)

      assign_seat_to_ticket!(seat_code)
    end
  end

  def seat_assigned?(pax_id)
    return false if seat_code.blank?

    boarding? && pax_id == passenger_id.to_i
  end

  def assign_seat_to_ticket!(seat_code)
    update!(
      seat_code: seat_code,
      status: "boarding"
    )
  end



  class SeatUnavailable < StandardError
    def initialize
      super("Seat unavailable")
    end
  end
end
