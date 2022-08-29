class CreateReservations < ActiveRecord::Migration[6.1]
  def change
    create_table :reservations do |t|
      t.references :table, null: false, foreign_key: true
      t.datetime :datetime
      t.string :customer_code
      t.integer :status
      
      t.timestamps
    end
  end
end
