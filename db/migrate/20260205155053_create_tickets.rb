class CreateTickets < ActiveRecord::Migration[8.0]
  def change
    create_table :tickets do |t|
      t.references :booking, null: false, foreign_key: true
      t.references :flight, null: false, foreign_key: true
      t.string :passenger_id
      t.datetime :issued_at
      t.string :seat_code
      t.integer :status

      t.timestamps
    end
  end
end
