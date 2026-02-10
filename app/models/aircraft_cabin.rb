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

  def seat_code_valid_format?(seat_code)
    # <COLUMN_LETTER><ROW_NUMBER>
    # example: A12, B22
    return false if seat_code.nil?
    return false unless seat_code.is_a?(String)
    return false if seat_code.size < 2

    col = seat_code[0]
    row_part = seat_code[1..-1]

    return false unless row_part.chars.all? { |c| c >= "0" && c <= "9" }
    row = row_part.to_i

    (row_start <= row && row <= row_end) && seat_columns.include?(col.upcase)
  end
end
