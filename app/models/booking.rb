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
      instance = create(
        booking_code: generate_code,
        phase: 3, # PENDING
        user_id: user_id,
        flight_id: flight_id,
        expired_at: BOOKING_EXPIRE_DURATION.from_now
      )

      passengers.each { |passenger| instance.passengers << passenger }
      instance
    end

  end

  def checkout_session!
    raise "already paid" if paid?
    raise "invalid booking" if cancelled? || expired?

    user.payment_processor.checkout(
      checkout_params
    )
  end

  def total_passengers
    passengers.size
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

    class InvalidPassenger < StandardError
      def initialize(message = "Invalid passanger data.")
        super
      end
    end

    class NotPaid < StandardError
      def initialize(message = "You booking is not paid yet.")
        super
      end
    end
  end

  private
  def checkout_params(**opts)
    {
      mode: "payment",
      success_url: opts[:success_url],
      client_reference_id: booking.id,
      payment_intent_data: {
        metadata: {
          flight_id: flight_id,
          user_id: user.id
        }
      },
      line_items: [
        {
          price_data: {
            currency: "usd",
            product_data: {
              name: "Flight ticket"
            },
            unit_amount: 2000 # example. please refer to "flight.original_price"
          },
          quantity: total_passengers
        }
      ]
    }
  end

end
