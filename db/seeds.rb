require "faker"

puts "Seeding database..."

Pigeon.destroy_all
User.destroy_all
coordinates = [
  [48.840604, 2.415190],
  [48.660798, 6.573836],
  [48.048060, -1.795912],
  [49.000981, 0.767703],
  [46.682387, 2.976668],
  [44.679240, -0.661031],
  [43.603087, 6.817025],
  [42.327800, 9.086787],
  [43.544358, 3.665703],
  [47.183827, 6.577104],
  [47.877094, 4.181280],
  [45.868461, -0.161889],
  [48.373399, -3.926756]
]

5.times do
  new_user = User.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: "#{Faker::Internet.username(specifier: 5..8)}-#{(rand * 1000).floor}@yopmail.com",
    password: "123456"
  )
  # a user can have 0, 1 or 2 pigeons
  (rand * 3).floor.times do
    coords = coordinates.sample
    Pigeon.create!(
      name: Faker::Name.first_name,
      description: Faker::Lorem.paragraphs(number: 2).join,
      maximum_payload_weight: (rand * 100).round(2),
      range: (rand * 1000).floor,
      latitude: coords[0],
      longitude: coords[1],
      address: Faker::Address.full_address,
      user: new_user
    )
  end
end

puts "Database seeded with #{User.count} users and #{Pigeon.count} pigeons."
