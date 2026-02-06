class AircraftCabin < ApplicationRecord
  belongs_to :aircraft

  enum :cabin_code, {
    F: "FIRST",
    J: "BUSINESS",
    Y: "ECONOMY"
  }

  def seat_by_aisle
    current = []
    seats = []

    seat_columns.each do |seat|
      current << seat

      if aisle_columns.include?(seat)
        seats << current
        current = []
      end
    end

    seats << current if current.any?
    seats
  end
end
