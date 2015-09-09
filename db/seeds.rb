# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Listing.new({
#     street: "1061 market st",
#     status: "active",
#     price: 100000,
#     bedrooms: 1,
#     bathrooms: 2,
#     sq_ft: 400,
#     lat: 32.4242,
#     lng: -122.4143
#   })

f = File.open("listings.csv", "r")

f.each_with_index do |line, idx|
  next if idx == 0
  data = line.chomp.split(",")

  Listing.create!({
    street: data[1],
    status: data[2],
    price: data[3].to_i,
    bedrooms: data[4].to_i,
    bathrooms: data[5].to_i,
    sq_ft: data[6].to_i,
    lat: data[7].to_f,
    lng: data[8].to_f
  })
end

f.close
