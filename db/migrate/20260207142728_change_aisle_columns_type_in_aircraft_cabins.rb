class ChangeAisleColumnsTypeInAircraftCabins < ActiveRecord::Migration[8.0]
  def change
    remove_column :aircraft_cabins, :aisle_columns
    add_column :aircraft_cabins, :aisle_columns, :string, array:true, default: [], null: false
  end

  def down
    remove_column :aircraft_cabins, :aisle_columns
    add_column :aircraft_cabins, :aisle_columns, :string
  end
end
