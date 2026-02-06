class AddDefaultToSeatsAvailabilityState < ActiveRecord::Migration[8.0]
  def change
    change_column_default :seats, :availability_state, "AVAILABLE"
  end

  def down
    change_column_default :seats, :availability_state, nil
  end
end
