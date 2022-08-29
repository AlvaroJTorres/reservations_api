class CreateCalendars < ActiveRecord::Migration[6.1]
  def change
    create_table :calendars do |t|
      t.references :restaurant, null: false, foreign_key: true
      t.date :date
      t.integer :reason, default: 0
      
      t.timestamps
    end
  end
end
