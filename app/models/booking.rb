class Booking < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :flight_seats

  enum :phase, {
    paid: "PAID",
    cancelled: "CANCELLED",
    pending: "PENDING",
    expired: "EXPIRED"
  }
end
