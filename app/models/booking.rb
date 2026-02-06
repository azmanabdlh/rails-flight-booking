class Booking < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :seats

  enum :phase, {
    paid: "PAID",
    cancelled: "CANCELLED",
    pending: "PENDING",
    expired: "EXPIRED"
  }

  BOOKING_EXPIRE_DURATION = 10.minutes


  class << self
    def generate_code
      SecureRandom.alphanumeric(8).upcase
    end

    def start_seat_booking!(
      flight_id,
      seat_code,
      user_id
    )
      transaction do
        seat = Seat
          .lock
          .find_or_create_by(flight_id: flight_id, seat_code: seat_code)

        raise SeatUnavailable unless seat.lockable?

        expired_at = BOOKING_EXPIRE_DURATION.from_now

        create!(
          booking_code: generate_code,
          user_id: user_id,
          phase: "PENDING",
          expired_at: expired_at
        ) << seat.reserve(expired_at)
      end
    end
  end


  class SeatAlreadyBooked < StandardError; end
  class SeatUnavailable < StandardError; end
end
