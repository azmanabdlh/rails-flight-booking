class Booking < ApplicationRecord
  belongs_to :user

  enum :phase, {
    paid: 1,
    cancelled: 2,
    pending: 3,
    expired: 4
  }

  BOOKING_EXPIRE_DURATION = 10.minutes

  def self.start_booking(
    flight_id,
    user_id
  )
    create(
      booking_code: generate_code,
      phase: 3, # PENDING
      user_id: user_id,
      flight_id: flight_id,
      expired_at: BOOKING_EXPIRE_DURATION.from_now
    )
  end


  class NotPaid < StandardError
    def initialize
      super("You booking is not paid yet.")
    end
  end

  private
  def generate_code
    "PNR#{SecureRandom.hex(4).upcase}"
  end

end
