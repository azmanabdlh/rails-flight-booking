
class FlightCabinSerializer
   include Alba::Resource

  attributes :cabin_code,
    :rows,
    :cabin,
    :seat_columns,
    :seats

  def rows
    { start: row_start, end: row_end }
  end

  def seat_columns
    seat_by_aisle
  end

  def seats; end
end