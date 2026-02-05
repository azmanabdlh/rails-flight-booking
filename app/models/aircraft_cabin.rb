class AircraftCabin < ApplicationRecord
  belongs_to :aircraft

  enum :cabin_code, {
    F: "FIRST",
    J: "BUSINESS",
    Y: "ECONOMY"
  }
end
