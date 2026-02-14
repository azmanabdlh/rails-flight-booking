class Passenger < ApplicationRecord

  scope :active, -> { where(active: true) }
  scope :not_deleted, -> { where(deleted_at: nil) }
  scope :deleted, -> { where.not(deleted_at: nil) }

  scope :available, -> { active.not_deleted }
end
