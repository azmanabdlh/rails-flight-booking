
class FlightCabinSerializer
   include Alba::Resource

  attributes :cabin_code
  attribute :cabin_class do |cabin|
    AircraftCabin.cabin_codes[cabin.cabin_code]
  end



  attribute :rows do |cabin|
    { start: cabin.row_start, end: cabin.row_end }
  end

  attribute :seat_by_aisle_columns do |cabin|
    cabin.seat_by_aisle
  end
end