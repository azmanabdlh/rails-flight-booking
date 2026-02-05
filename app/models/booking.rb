class Booking < ApplicationRecord

  extend ClassMethods

  belongs_to :user
  has_and_belongs_to_many :flight_seats

  enum :phase, {
    paid: "PAID",
    cancelled: "CANCELLED",
    pending: "PENDING",
    expired: "EXPIRED"
  }

  module ClassMethods
    def mark_seat_book(user_id)
      transaction do
        # TODO ..
        # 1. lock the seat.
        # 2. assign seat to book pivot table
        # 3. done
      end
    end
  end
end
