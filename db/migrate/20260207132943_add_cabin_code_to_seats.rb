class AddCabinCodeToSeats < ActiveRecord::Migration[8.0]
  def change
    add_column :seats, :cabin_code, :string
  end

  def down
    drop_column :seats, :cabin_code
  end
end
