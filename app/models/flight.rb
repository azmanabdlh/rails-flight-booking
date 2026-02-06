class Flight < ApplicationRecord
  belongs_to :aircraft
  has_many :seats

  enum :operational_state, {
    open_for_sale: 1,
    closed: 2,
    cancelled: 3
  }

end
