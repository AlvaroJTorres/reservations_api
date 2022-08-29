class CreateOfficeHours < ActiveRecord::Migration[6.1]
  def change
    create_table :office_hours do |t|
      t.references :restaurant, null: false, foreign_key: true
      t.integer :day, default: 1
      t.time :open
      t.time :close
      
      t.timestamps
    end
  end
end
