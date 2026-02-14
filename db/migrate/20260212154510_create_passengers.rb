class CreatePassengers < ActiveRecord::Migration[8.0]
  def change
    create_table :passengers do |t|
      t.string :first_name
      t.string :last_name
      t.date :birth_date
      t.boolean :active
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
