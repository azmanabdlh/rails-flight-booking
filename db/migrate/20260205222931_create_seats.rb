class CreateSeats < ActiveRecord::Migration[8.0]
  def change
    create_table :seats do |t|
      t.references :flight, null: false, foreign_key: true
      t.string :seat_code
      t.string :availability_state
      t.datetime :locked_until

      t.timestamps
    end
  end
end
