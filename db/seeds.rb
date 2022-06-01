# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

puts "Cleaning database!"
Pokemon.destroy_all
User.destroy_all
puts "Creating pokemon"

10.times do
  user = User.create(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    gender: Faker::Gender.binary_type,
    email: Faker::Internet.email,
    password: Faker::Internet.password
  )
  Pokemon.create(
    name: Faker::Games::Pokemon.name,
    move: Faker::Games::Pokemon.move,
    address: Faker::Address.full_address,
    element: %w[Normal Fire Electric Rock Water].sample,
    user: user
  )
  puts "Creating #{user.email}"
end

puts "Finished seeding database"
