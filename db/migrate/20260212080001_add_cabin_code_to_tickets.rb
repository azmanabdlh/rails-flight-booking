class AddCabinCodeToTickets < ActiveRecord::Migration[8.0]
  def change
    add_column :tickets, :cabin_code, :string
  end

  def down
    drop_column :tickets, :cabin_code
  end
end
