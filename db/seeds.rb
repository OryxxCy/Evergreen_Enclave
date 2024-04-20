require 'json'
require 'open-uri'

TaxRate.destroy_all
Plant.destroy_all
PlantType.destroy_all
AdminUser.destroy_all
User.destroy_all
Order.destroy_all
OrderPlant.destroy_all

tax_rates_data = [
  { province: "Alberta", pst: 0, gst: 5, hst: 0 },
  { province: "British Columbia", pst: 7, gst: 5, hst: 0 },
  { province: "Manitoba", pst: 7, gst: 5, hst: 0 },
  { province: "New Brunswick", pst: 0, gst: 0, hst: 15 },
  { province: "Newfoundland and Labrador", pst: 0, gst: 0, hst: 15 },
  { province: "Northwest Territories", pst: 0, gst: 5, hst: 0 },
  { province: "Nova Scotia", pst: 0, gst: 0, hst: 15 },
  { province: "Nunavut", pst: 0, gst: 5, hst: 0 },
  { province: "Ontario", pst: 0, gst: 0, hst: 13 },
  { province: "Prince Edward Island", pst: 0, gst: 0, hst: 15 },
  { province: "Quebec", pst: 9.975, gst: 5, hst: 0 },
  { province: "Saskatchewan", pst: 6, gst: 5, hst: 0 },
  { province: "Yukon", pst: 0, gst: 5, hst: 0 }
]

tax_rates_data.each do |tax_rate_data|
  TaxRate.create(tax_rate_data)
end

100.times do |i|
  url = "https://perenual.com/api/species/details/#{(i * 9) + 155}?key=sk-IgYw660f03b1b54ee4873"
  response = URI.open(url).read
  data = JSON.parse(response)

  common_name = data['common_name'].capitalize()
  other_names = data['other_name'].join(', ') unless data['other_name'].empty?
  type = data['type'].capitalize()
  description = data['description']
  price = Faker::Number.decimal(l_digits: 2)
  stock = Faker::Number.between(from: 1, to: 50)

  plant_type = PlantType.find_or_create_by(name: type)

  plant = Plant.create(
    name: common_name,
    other_name: other_names || 'None',
    plant_type: plant_type,
    description: description,
    price: price,
    stock: stock
  )

  if data['default_image'].present?
    if data['default_image']['regular_url'].present?
      downloaded_image = URI.open(data['default_image']['regular_url'])
      plant.image.attach(io:downloaded_image, filename: "#{common_name}.jpg")
    end
  end
  sleep(3)
  puts i
  puts "Saved!"
  puts "Total Plants Count: #{Plant.count}"
end
AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?
