class User < ApplicationRecord
  pay_customer default_payment_processor: :stripe

  def create_payment_session(booking)
    total_quantity = booking.passengers.size
    payment_processor.checkout(
      mode: "payment",
      success_url: "https://example.com/success",
      line_items: [
        {
          price_data: {
            currency: "usd",
            product_data: {
              name: "Flight ticket",
            },
            unit_amount: 2000 # example. please refer to "flight.original_price"
          },
          quantity: total_quantity
        }
      ]
    )
  end
end
