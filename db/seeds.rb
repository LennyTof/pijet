require "faker"

puts "Seeding database..."
Pigeon.destroy_all
User.destroy_all

3.times do
  new_user = User.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: "#{Faker::Internet.username(specifier: 5..8)}-#{(rand * 1000).floor}@yopmail.com",
    password: "123456"
  )
  # a user can have 0, 1 or 2 pigeons
  (rand * 3).floor.times do
    Pigeon.create!(
      name: Faker::Name.first_name,
      description: Faker::Lorem.paragraphs(number: 2).join,
      maximum_payload_weight: (rand * 100).round(2),
      range: (rand * 1000).floor,
      latitude: Faker::Address.latitude,
      longitude: Faker::Address.longitude,
      address: Faker::Address.full_address,
      user: new_user
    )
  end
end

puts "Database seeded with #{User.count} users and #{Pigeon.count} pigeons."
