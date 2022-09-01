# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts 'Start seeding'

puts 'Seeding users'

admin_data = {
    email: "alvaro.torres.m@upch.pe",
    name: "Alvaro Julian Torres Malla",
    role: 1,
    gmail_id: "101222949401547317555"
}

User.create(admin_data) unless User.find_by(role: 1)

manager_data = {
    email: "juanperto1779@gmail.com",
    name: "Juan Perto",
    role: 2,
    gmail_id: "101213949938108166954"
}

User.create(manager_data)

facebook_customer_data = {
    email: "bluelight3001@hotmail.com",
    name: "Alvaro Julian Torres Malla",
    facebook_id: "5614316765255774"
}

User.create(facebook_customer_data)

puts 'Finished seeding users'

puts 'Seeding restaurants'

manager = User.find_by(email: "juanperto1779@gmail.com")

restaurant_data = {
    name: "Test Restaurant",
    address: Faker::Address.street_address,
    user_id: manager.id,
}

new_restaurant = Restaurant.new(restaurant_data)

new_restaurant.images.attach([io: File.open('public/images/restaurant1.jpg'), filename: 'restaurant1.jpg', io: File.open('public/images/restaurant2.jpg'), filename: 'restaurant2.jpg'])

new_restaurant.save

puts 'Finished seeding restaurants'

restaurant = Restaurant.find_by(name: "Test Restaurant")

puts 'Seeding office hours'

monday = {
    restaurant_id: restaurant.id,
    day: 1,
    open: "12:00",
    close: "21:00"
}

OfficeHour.create(monday)

wednesday = {
    restaurant_id: restaurant.id,
    day: 3,
    open: "12:00",
    close: "16:00"
}

OfficeHour.create(wednesday)

friday  = {
    restaurant_id: restaurant.id,
    day: 5,
    open: "19:00",
    close: "23:00"
}

OfficeHour.create(friday)

puts 'Finished seeding office hours'

puts 'Seeding calendars'

holiday = {
    restaurant_id: restaurant.id,
    date: "28/07/2022" 
}

Calendar.create(holiday)

closed_day = {
    restaurant_id: restaurant.id,
    date: "30/08/2022",
    reason: 1
}

Calendar.create(closed_day)

puts 'Finished seeding calendars'

puts 'Seeding tables'

5.times do |i|
    table_data = {
        restaurant_id: restaurant.id,
        seats: rand(1..8),
        description: "Table n#{i + 1}"
    }

    Table.create(table_data)
end

puts 'Finished seeding tables'

puts 'Seeding Reservations'
table = Table.find(1)

reservation_data = {
    table_id: 1,
    datetime: "05/09/2022-11:00",
    customer_code: "1234567890",
    status: 1
}

Reservation.create(reservation_data)

puts 'Finished seeding reservations'