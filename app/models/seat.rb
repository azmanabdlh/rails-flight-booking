class Seat < ApplicationRecord
  belongs_to :flight
  has_and_belongs_to_many :bookings

  enum :availability_state, {
    locked: "LOCKED",
    available: "AVAILABLE",
    reserved: "RESERVED"
  }

  def lockable?
    available? || (locked? && locked_until < Time.current)
  end

  def reserve(locked_until)
    update!(
      availability_state: "LOCKED",
      locked_until: locked_until
    )
  end

  def release; end

end
