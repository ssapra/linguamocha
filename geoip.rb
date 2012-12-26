
require 'geocoder'
require 'pp'

# pp Geocoder.coordinates("25 Main St, Cooperstown, NY")

# results = Geocoder.search("McCarren Park, Brooklyn, NY")

results = Geocoder.search('24.193.83.1')

pp results[0].city