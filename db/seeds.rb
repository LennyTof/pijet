require "faker"
require "open-uri"

Faker::Config.locale = :fr

puts "Seeding database..."
User.destroy_all
PayloadType.destroy_all

PayloadType.create!(name: "Paper", weight: 5)
PayloadType.create!(name: "SD card", weight: 7)
PayloadType.create!(name: "USB key", weight: 15)
PayloadType.create!(name: "Hard drive", weight: 500)
PayloadType.create!(name: "Storage server", weight: 50_000)

france_coordinates = [
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
  [48.373399, -3.926756],
  [41.524578, 9.091708],
  [42.573068, 2.559167],
  [44.710528, 2.174606],
  [46.157827, 6.229977],
  [44.785015, -0.831962],
  [46.266691, 0.566442],
  [46.363278, 3.136009],
  [48.317420, 4.918974],
  [46.903403, 2.384367],
  [47.153617, -0.045360]
].shuffle!

3.times do
  new_user = User.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: "#{Faker::Internet.username(specifier: 5..8)}-#{(rand * 1000).floor}@yopmail.com",
    password: "123456"
  )
  # a user can have 0, 1, ... or 5 pigeons
  (rand * 6).floor.times do
    coords = france_coordinates.pop
    new_pigeon = Pigeon.create!(
      name: Faker::Name.first_name,
      description: Faker::Lorem.paragraphs(number: 2).join,
      maximum_payload_weight: (rand * 100).round(2),
      range: (rand * 1000).floor,
      address: Faker::Address.full_address,
      latitude: coords[0],
      longitude: coords[1],
      price: (rand * 9).ceil * 10,
      grooming_fee: 100,
      user: new_user
    )
    file = URI.parse(Faker::LoremFlickr.image(size: "400x400", search_terms: ['pigeon'])).open
    new_pigeon.photo.attach(io: file, filename: "#{new_pigeon.id}.png", content_type: "image/png")
  end
end

puts "Database seeded with #{User.count} users and #{Pigeon.count} pigeons."
