class Booking < ApplicationRecord
  belongs_to :user

  enum :phase, {
    paid: 1,
    cancelled: 2,
    pending: 3,
    expired: 4
  }

  BOOKING_EXPIRE_DURATION = 10.minutes


  class NotPaid < StandardError; end

  private
  def generate_code
    SecureRandom.alphanumeric(8).upcase
  end

end
