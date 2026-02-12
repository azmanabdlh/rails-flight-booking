class Ticket < ApplicationRecord
  belongs_to :booking
  belongs_to :flight

  enum :status, {
    issued: 1,
    boarding: 2,
    departed: 3,
    arrived: 4
  }

  def self.seat_available?(flight_id, seat_code)
    not lock.find_by(
      flight_id: flight_id,
      seat_code: seat_code
    ).nil?
  end

  def start_confirm_seat!(
    flight_id,
    seat_code,
    user_id
  )
    transaction do
      return nil if ticket.seat_assigned?

      raise Booking::NotPaid unless booking.paid?
      raise Ticket::SeatUnavailable, seat_code unless Ticket.seat_available?(
        request[:flight_id],
        request[:seat_code]
      )

      assign_seat_to_ticket!(seat_code)
    end
  end

  def seat_assigned?
    seat_code != "" && boaring?
  end

  def assign_seat_to_ticket!(seat_code)
    update!(
      # TODO: pessager snapshot...
      seat_code: seat_code,
      status: "boarding",
    )
  end



  class SeatUnavailable < StandardError
    def initialize(seat_code)
      super("Seat #{seat_code} is unavailable")
    end
  end
end
