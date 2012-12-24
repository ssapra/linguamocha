require 'rubygems'
require 'oauth'
require 'pp'
require 'json'

consumer_key = 'EcxkaDnICiYJE2PZm_OeCw'
consumer_secret = 'Yqc_OOMULadnzTs7Juj8bmZN3Ng'
token = 'sKXNbkV6k17LqXx3Rjl21BzvpP26O9CF'
token_secret = '8EuUtxYMsqGD89qtIRkDj-LOXKg'

api_host = 'api.yelp.com'

consumer = OAuth::Consumer.new(consumer_key, consumer_secret, {:site => "http://#{api_host}"})
access_token = OAuth::AccessToken.new(consumer, token, token_secret)

puts "What is your location"
current_location = gets.chomp

cl = current_location.split(" ").join("+")

path = "/v2/search?term=cafe+coffee&location=#{cl}"

string =  access_token.get(path).body

json = JSON.parse(string)

puts ''

json["businesses"].each do |business|
  # pp business 
  puts business["name"]
  loc = business["location"]
  puts loc["address"]
  puts loc["neighborhoods"] if loc["neighborhoods"]
  puts "#{loc["city"]}, #{loc["state_code"]} #{loc["postal_code"]}"
  puts ""
end