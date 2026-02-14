class CreatePassengerSnapshots < ActiveRecord::Migration[8.0]
  def change
    create_table :passenger_snapshots do |t|
      t.references :passenger, null: false, foreign_key: true
      t.references :booking, null: false, foreign_key: true
    end
  end

  def down
    drop_table :passenger_snapshots
  end
end