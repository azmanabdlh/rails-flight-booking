class AddSeatColumnsToAircraftCabins < ActiveRecord::Migration[8.0]
  def change
    add_column :aircraft_cabins, :seat_columns, :string, array:true, default: [], null: false
  end

  def down
    drop_column :aircraft_cabins, :seat_columns
  end
end
