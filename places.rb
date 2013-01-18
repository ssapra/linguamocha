require 'json'
require 'open-uri'
require 'pp'

uri = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=41.785841,-87.597256&radius=1000&types=cafe&sensor=false&key=AIzaSyAZO08sPxtMwOgkgrAVYdYbPqIm0FxQUwk"

json = JSON.parse(open(uri).read)

pp json

json["results"].each do |result|
  puts result["name"]
  loc = result["vicinity"].split(", ")
  loc.each {|l| puts l}
  if result["rating"] then puts "Rating: #{result["rating"]}" else puts "Rating: --" end
  puts result["geometry"]["location"]["lat"]
  puts result["geometry"]["location"]["lng"]
  puts
end