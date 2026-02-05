class Ticket < ApplicationRecord
  belongs_to :booking
  belongs_to :flight

  enum :status, {
    issued: 1,
    boarding: 2,
    departed: 3,
    arrived: 4
    # ....
  }

end
