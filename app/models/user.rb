class User < ApplicationRecord
  pay_customer default_payment_processor: :stripe

  def create_payment_session(booking, **options)
    total_quantity = booking.passengers.size
    payment_processor.checkout(
      mode: "payment",
      success_url: options[:success_url],
      client_reference_id: booking.id,
      payment_intent_data: {
        metadata: {
          flight_id: booking.flight_id,
          user_id: id,
        },
      },
      metadata: {
        flight_id: booking.flight_id,
        user_id: id,
      },
      line_items: [
        {
          price_data: {
            currency: "usd",
            product_data: {
              name: "Flight ticket",
            },
            unit_amount: 2000 # example. please refer to "flight.original_price"
          },
          quantity: total_quantity,
        }
      ]
    )
  end
end
