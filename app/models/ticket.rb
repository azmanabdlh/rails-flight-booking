class Ticket < ApplicationRecord
  belongs_to :booking
  belongs_to :flight

  enum :status, {
    issued: 1,
    boarding: 2,
    departed: 3,
    arrived: 4
  }


  def start_confirm_seat!(
    flight_id,
    seat_code,
    user_id
  )
    transaction do
      return nil if ticket.seat_assigned?
      raise SeatUnavailable.new(seat_code) unless ticket.seat_available?

      boarding_seat(seat_code)
    end
  end

  def seat_assigned?
    not seat_code.blank?
  end

  def boarding_seat(seat_code)
    update(
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
