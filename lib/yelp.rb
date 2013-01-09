module Yelp
  
  def self.coordinates(params)
    json = Yelp.request(params)
    
    coordinates = []
    
    json["businesses"].first(10).each do |business|
      coordinates << {:lat => business["location"]["coordinate"]["latitude"], :long => business["location"]["coordinate"]["longitude"]}
    end
    
    coordinates
  end
  
  def self.businesses(params)
    json = Yelp.request(params)
    
    points = []

    json["businesses"].first(10).each do |business|
      points << {:name => business["name"], 
                 :address => business["location"]["address"][0],
                 :review_count => business["review_count"],
                 :rating_url => business["rating_img_url_small"]}
    end
    
    points
  end
  
  def self.request(params)
    consumer_key = 'EcxkaDnICiYJE2PZm_OeCw'
    consumer_secret = 'Yqc_OOMULadnzTs7Juj8bmZN3Ng'
    token = 'sKXNbkV6k17LqXx3Rjl21BzvpP26O9CF'
    token_secret = '8EuUtxYMsqGD89qtIRkDj-LOXKg'

    api_host = 'api.yelp.com'

    consumer = OAuth::Consumer.new(consumer_key, consumer_secret, {:site => "http://#{api_host}"})
    access_token = OAuth::AccessToken.new(consumer, token, token_secret)
    
    cl = params.split(" ").join("+")

    path = "/v2/search?term=cafe+coffee&location=#{cl}#find_loc=#{cl}&show_filters=1"

    string =  access_token.get(path).body

    json = JSON.parse(string)
    
  end
  
end