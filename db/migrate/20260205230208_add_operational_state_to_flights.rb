class AddOperationalStateToFlights < ActiveRecord::Migration[8.0]
  def change
    add_column :flights, :operational_state, :integer
  end

  def down
    drop_column :flights, :operational_state
  end
end
