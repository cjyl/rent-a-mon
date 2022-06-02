require 'open-uri'
require 'json'
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

15.times do
  user = User.create(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    gender: Faker::Gender.binary_type.downcase,
    email: Faker::Internet.email,
    password: Faker::Internet.password
  )

  puts name = Faker::Games::Pokemon.name
  url = "https://pokeapi.co/api/v2/pokemon/#{name.downcase}"
  pokemon = JSON.parse(URI.open(url).read)
  type = pokemon['types'][0]['type']['name']
  moves = pokemon['abilities'].map! do |ability|
    ability['ability']['name'].capitalize
  end
  abilities = moves.join('; ')
  image_path = pokemon['sprites']['other']['official-artwork']['front_default']

  Pokemon.create(

    name: name,
    move: abilities,
    address: %w[Westminster Southwark Lambeth Hackney Greenwich Islington Chelsea Kensington Woolwich Hoxton Whitechapel].sample,
    element: type,
    image_path: image_path,
    user: user
  )
  # puts "Creating #{user.email}"
end


puts "Finished seeding database"
