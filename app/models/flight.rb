class Flight < ApplicationRecord
  belongs_to :aircraft
  has_and_belongs_to_many :bookings
end
