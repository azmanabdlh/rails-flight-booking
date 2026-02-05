class CreateAircraftCabins < ActiveRecord::Migration[8.0]
  def change
    create_table :aircraft_cabins do |t|
      t.references :aircraft, null: false, foreign_key: true
      t.string :cabin_code
      t.integer :row_start
      t.integer :row_end
      t.jsonb :row_features
      t.string :aisle_columns

      t.timestamps
    end
  end
end
