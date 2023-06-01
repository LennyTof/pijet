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

france_coordinates = JSON.parse(File.read("#{Rails.root}/db/france_coordinates.json")).shuffle!

pigeon_picture_paths = Dir.glob("#{Rails.root}/app/assets/images/pigeons/*")
user_picture_paths = Dir.glob("#{Rails.root}/app/assets/images/users/*")

10.times do
  user = User.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: "#{Faker::Internet.username(specifier: 5..8)}-#{(rand * 1000).floor}@yopmail.com",
    password: "123456"
  )
  # a user can have 0, 1, ... or 10 pigeons
  (0..10).to_a.sample.times do
    coords = france_coordinates.pop
    pigeon = Pigeon.create!(
      name: Faker::Name.first_name,
      description: Faker::Lorem.paragraphs(number: 2).join,
      maximum_payload_weight: (rand * 100).round(2),
      range: (rand * 1000).floor,
      address: Faker::Address.full_address,
      latitude: coords[1],
      longitude: coords[0],
      price: (rand * 9).ceil * 10,
      grooming_fee: 100,
      user: user,
    )
    file = File.open(pigeon_picture_paths.sample)
    pigeon.photo.attach(io: file, filename: "#{pigeon.id}.", content_type: "image/jpeg")
  end
end

puts "Database seeded with #{User.count} users and #{Pigeon.count} pigeons."
