class FlightSeat < ApplicationRecord
  belongs_to :flight

  enum :availability_state, {
    locked: "LOCKED",
    available: "AVAILABLE",
    reserved: "RESERVED"
  }

end
