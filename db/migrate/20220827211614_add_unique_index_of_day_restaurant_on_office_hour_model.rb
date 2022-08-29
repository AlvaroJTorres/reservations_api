class AddUniqueIndexOfDayRestaurantOnOfficeHourModel < ActiveRecord::Migration[6.1]
  def change
    add_index :office_hours, %i[day restaurant_id], unique: true
  end
end
