require "faker"
require "open-uri"

Faker::Config.locale = :fr

puts "Seeding database..."
User.destroy_all
Rental.destroy_all

france_coordinates = JSON.parse(File.read("#{Rails.root}/db/france_coordinates.json")).shuffle!
pigeon_picture_paths = Dir.glob("#{Rails.root}/app/assets/images/pigeons/*").shuffle!
user_picture_paths = Dir.glob("#{Rails.root}/app/assets/images/users/*").shuffle!

# 10 regular users
counter = 0
30.times do
  user = User.new(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: "#{Faker::Internet.username(specifier: 5..8)}-#{rand(1000)}@yopmail.com",
    password: "123456"
  )
  user_file = File.open(user_picture_paths[counter % user_picture_paths.length])
  user.photo.attach(io: user_file, filename: "#{user.id}.", content_type: "image/jpeg")
  user.save!
  counter += 1
end

# 50 pigeons
counter = 0
60.times do
  user_offset = rand(User.count)
  coords = france_coordinates.pop
  pigeon = Pigeon.new(
    name: Faker::Name.first_name,
    description: Faker::Hipster.paragraphs(number: 4).join,
    maximum_payload_weight: (rand * 100).round(2),
    range: rand(1001),
    address: Faker::Address.full_address,
    latitude: coords[1],
    longitude: coords[0],
    price: rand(100) + 1,
    grooming_fee: rand(101),
    user: User.offset(user_offset).first
  )
  pigeon_file = File.open(pigeon_picture_paths[counter % pigeon_picture_paths.length])
  pigeon.photo.attach(io: pigeon_file, filename: "#{pigeon.id}.", content_type: "image/jpeg")
  pigeon.save!
  counter += 1
end

# 100 rentals
100.times do
  start_date = Faker::Date.between(from: 10.days.ago, to: Date.today + 60)
  end_date = start_date + rand(6)
  pigeon_offset = rand(Pigeon.count)
  user_offset = rand(User.count - 1)
  pigeon = Pigeon.offset(pigeon_offset).first
  renter = User.excluding(pigeon.user).offset(user_offset).first
  Rental.create!(
    start_date:,
    end_date:,
    price: rand(501),
    payload_weight: rand(11),
    status: %w[pending accepted refused].sample,
    pigeon:,
    user: renter
  )
end

# 200 reviews
200.times do
  rental_offset = rand(Rental.count)
  rental = Rental.offset(rental_offset).first
  Review.create!(
    comment: Faker::Hipster.paragraphs(number: 2).join,
    rating: rand(6),
    rental:,
    user: [rental.user, rental.pigeon.user].sample
  )
end

# admin user
admin = User.new(
  first_name: Faker::Name.first_name,
  last_name: Faker::Name.last_name,
  email: "admin@pijet.com",
  password: "password"
)
admin.photo.attach(io: File.open(user_picture_paths.sample), filename: "#{admin.id}.", content_type: "image/jpeg")
admin.save!

puts <<-TEXT
  Database seeded with
  #{User.count} users,
  #{Pigeon.count} pigeons,
  #{Rental.count} rentals and
  #{Review.count} reviews."
TEXT
