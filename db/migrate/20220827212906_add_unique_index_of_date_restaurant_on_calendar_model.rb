class AddUniqueIndexOfDateRestaurantOnCalendarModel < ActiveRecord::Migration[6.1]
  def change
    add_index :calendars, %i[date restaurant_id], unique: true
  end
end
