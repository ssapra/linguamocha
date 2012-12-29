
require 'geocoder'
require 'pp'

# pp Geocoder.coordinates("25 Main St, Cooperstown, NY")

# results = Geocoder.search("McCarren Park, Brooklyn, NY")

results = Geocoder.search('24.193.82.1')

city = results[0].city

if city != "" then pp city else puts "City Not Found" end