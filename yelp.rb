require 'rubygems'
require 'oauth'
require 'pp'
require 'json'
require 'geoip'

consumer_key = 'EcxkaDnICiYJE2PZm_OeCw'
consumer_secret = 'Yqc_OOMULadnzTs7Juj8bmZN3Ng'
token = 'sKXNbkV6k17LqXx3Rjl21BzvpP26O9CF'
token_secret = '8EuUtxYMsqGD89qtIRkDj-LOXKg'

api_host = 'api.yelp.com'

consumer = OAuth::Consumer.new(consumer_key, consumer_secret, {:site => "http://#{api_host}"})
access_token = OAuth::AccessToken.new(consumer, token, token_secret)

puts "What is your location"
current_location = gets.chomp

# interface = UrbanMapping::Interface.new('cb5d8d502a625083c77181341a7a5e5f')

# hoods = interface.get_neighborhoods_by_postal_code(loc["postal_code"])

# pp hoods


cl = current_location.split(" ").join("+")

path = "/v2/search?term=cafe+coffee&location=#{cl}"

string =  access_token.get(path).body

json = JSON.parse(string)

puts ''

points = []

json["businesses"].each do |business|
  pp business 
  # puts business["name"]
  # loc = business["location"]
  # puts loc["address"]
  # puts loc["neighborhoods"] if loc["neighborhoods"]
  # puts "#{loc["city"]}, #{loc["state_code"]} #{loc["postal_code"]}"
  # puts "[#{loc["coordinate"]["latitude"]}, #{loc["coordinate"]["longitude"]}]"
  # points << [loc["coordinate"]["latitude"], loc["coordinate"]["longitude"]]
  puts ""
end

location_string = ""

points.each_with_index do |point, i|
  c = (i+97).chr.upcase
  location_string += "&markers=color:red%7Clabel:#{c}%7C#{point[0]},#{point[1]}"
  if i == 10 then break end
end

puts "http://maps.googleapis.com/maps/api/staticmap?zoom=13&size=600x300&maptype=roadmap" + location_string + "&sensor=false"
# 
# "http://maps.googleapis.com/maps/api/staticmap?zoom=13&size=600x300&maptype=roadmap
# &markers=color:red%7Clabel:1%7C40.702147,-74.015794
# &markers=color:red%7Clabel:2%7C40.711614,-74.012318
# &markers=color:red%7Clabel:3%7C40.718217,-73.998284&sensor=false"