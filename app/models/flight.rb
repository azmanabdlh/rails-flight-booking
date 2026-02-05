class Flight < ApplicationRecord
  belongs_to :aircraft
  has_many :seats

  enum :operational_state, {
    open_for_sale: 1,
    closed: 2,
    cancelled: 3
  }

  def seat_available?(code)
    seat = seats.find_by(seat_code: code)

    (seat.blank? || seat.available?) && open_for_sale?
  end
end
