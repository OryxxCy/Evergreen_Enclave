require 'json'
require 'open-uri'

10.times do |i|
  url = "https://perenual.com/api/species/details/#{i+1}?key=sk-AC7C660314a6c9c524873"
  response = URI.open(url).read
  data = JSON.parse(response)

  common_name = data['common_name']
  other_names = data['other_name'].join(', ') unless data['other_name'].empty?
  type = data['type']
  description = data['description']
  price = Faker::Number.decimal(l_digits: 2)

  plant_type = PlantType.find_or_create_by(name: type)

  plant = Plant.create(
    name: common_name,
    other_name: other_names || 'None',
    plant_type: plant_type,
    description: description,
    price: price
  )

  downloaded_image = URI.open(data['default_image']['regular_url'])
  plant.image.attach(io:downloaded_image, filename: "#{common_name}.jpg")
  sleep(1)
  puts "Saved!"
end

# tax_rates_data = [
#   { province: "Alberta", pst: nil, gst: 5, hst: nil },
#   { province: "British Columbia", pst: 7, gst: 5, hst: nil },
#   { province: "Manitoba", pst: 7, gst: 5, hst: nil },
#   { province: "New Brunswick", pst: nil, gst: nil, hst: 15 },
#   { province: "Newfoundland and Labrador", pst: nil, gst: nil, hst: 15 },
#   { province: "Northwest Territories", pst: nil, gst: 5, hst: nil },
#   { province: "Nova Scotia", pst: nil, gst: nil, hst: 15 },
#   { province: "Nunavut", pst: nil, gst: 5, hst: nil },
#   { province: "Ontario", pst: nil, gst: nil, hst: 13 },
#   { province: "Prince Edward Island", pst: nil, gst: nil, hst: 15 },
#   { province: "Quebec", pst: 9.975, gst: 5, hst: nil },
#   { province: "Saskatchewan", pst: 6, gst: 5, hst: nil },
#   { province: "Yukon", pst: nil, gst: 5, hst: nil }
# ]

# tax_rates_data.each do |tax_rate_data|
#   TaxRate.create(tax_rate_data)
# end