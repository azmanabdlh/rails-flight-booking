class Booking < ApplicationRecord
  extend ClassMethods

  LOCK_DURATION = 30.minutes

  belongs_to :user
  has_and_belongs_to_many :seats

  enum :phase, {
    paid: "PAID",
    cancelled: "CANCELLED",
    pending: "PENDING",
    expired: "EXPIRED"
  }

  module ClassMethods

    def generate_code;end

    def reserve_seat!(flight_id, seat, user_id)
      create!(
        booking_code: generate_code,
        user_id: user_id,
        phase: "PENDING",
        expired_at: LOCK_DURATION.from_now
      )

      seat.update!(
        availability_state: "LOCKED",
        locked_until: LOCK_DURATION.from_now
      )

    end

    def start_seat_book(
      flight_id,
      seat_code,
      user_id
    )
      transaction do
        seat = Seat
          .lock
          .find_or_create_by(flight_id: flight_id, seat_code: seat_code)

        raise SeatUnavailable unless seat.lockable?

        reserve_seat!(flight_id, seat, user_id)
      end
    end
  end


  class SeatAlreadyBooked < StandardError; end
  class SeatUnavailable < StandardError; end
end
