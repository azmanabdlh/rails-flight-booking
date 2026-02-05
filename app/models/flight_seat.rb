class FlightSeat < ApplicationRecord
  belongs_to :flight
  has_and_belongs_to_many :bookings

  enum :availability_state, {
    locked: "LOCKED",
    available: "AVAILABLE",
    reserved: "RESERVED"
  }

end
