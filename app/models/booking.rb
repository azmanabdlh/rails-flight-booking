class Booking < ApplicationRecord
  belongs_to :user

  has_and_belongs_to_many :passengers, join_table: "passenger_snapshots"

  enum :phase, {
    paid: 1,
    cancelled: 2,
    pending: 3,
    expired: 4
  }

  BOOKING_EXPIRE_DURATION = 10.minutes

  def self.generate_code
    "PNR#{SecureRandom.hex(4).upcase}"
  end

  def self.start_booking(
    flight_id,
    passengers,
    user_id
  )
    raise Exception::MissingPassenger if passengers.empty?

    transaction do
      booking_instance = create(
        booking_code: generate_code,
        phase: 3, # PENDING
        user_id: user_id,
        flight_id: flight_id,
        expired_at: BOOKING_EXPIRE_DURATION.from_now
      )

      passengers.each do |passenger|
        booking_instance.passengers << passenger
      end
    end

  end

  def allowed_passenger?(passenger_id)
    passengers.pluck(:id).include?(passenger_id)
  end

  module Exception
    class MissingPassenger < StandardError
      def initialize(message = "Passenger data is required for this operation.")
        super
      end
    end

    class NotPaid < StandardError
      def initialize(message = "You booking is not paid yet.")
        super
      end
    end
  end

end
