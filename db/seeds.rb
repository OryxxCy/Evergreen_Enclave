require 'json'
require 'open-uri'

# 4.times do |i|
#   url = "https://perenual.com/api/species-list?key=sk-AC7C660314a6c9c524873&page=#{i}"
#   response = URI.open(url).read
#   data = JSON.parse(response)

#   data['data'].each do |plant|
#     common_name = plant['common_name']
#     other_names = plant['other_name'][1] unless plant['other_name'].empty?

#     puts "Common Name: #{common_name}"
#     puts "Other Names: #{other_names || 'None'}"
#     puts "--------"
#   end
# end

url = "https://perenual.com/api/species-list?key=sk-AC7C660314a6c9c524873&page=1"
response = URI.open(url).read
data = JSON.parse(response)

data['data'].first(2).each do |plant|
  common_name = plant['common_name']
  other_names = plant['other_name'].join(', ') unless plant['other_name'].empty?

  url = "https://perenual.com/api/species/details/#{plant['id']}?key=sk-AC7C660314a6c9c524873"
  response = URI.open(url).read
  data = JSON.parse(response)
  type = data['type']
  description = data['description']
  price = Faker::Number.decimal(l_digits: 2)

  puts "Common Name: #{common_name}"
  puts "Other Names: #{other_names || 'None'}"
  puts "Type: #{type.capitalize}"
  puts "Description: #{description}"
  puts "Description: #{price}"
  puts "--------"
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