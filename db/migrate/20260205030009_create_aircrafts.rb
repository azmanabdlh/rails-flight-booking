class CreateAircrafts < ActiveRecord::Migration[8.0]
  def change
    create_table :aircrafts do |t|
      t.string :manufacturer
      t.string :model
      t.string :variant
      t.integer :manufacture_year

      t.timestamps
    end
  end
end
