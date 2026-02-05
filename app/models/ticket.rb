class Ticket < ApplicationRecord
  belongs_to :booking
  belongs_to :flight
end
