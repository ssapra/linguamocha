module Places
  
  def self.coordinates(params)
    json = Places.request(params)
    
    coordinates = []
    
    json["results"].each do |result|
      coordinates << {:lat => result["geometry"]["location"]["lat"], :long => business["geometry"]["location"]["lng"]}
    end
    
    coordinates
  end
  
  def self.businesses(params)
    json = Places.request(params)
    
    points = []

    json["results"].first(10).each do |result|
      points << {:name => result["name"], 
                 :address => result["vicinity"]
                 # :rating => result["rating"]
               }
                 # :city => result["location"]["city"],
                 # :state => business["location"]["state_code"],
                 # :review_count => result["rating"]
    end
    
    points
  end
  
  def self.request(params)
    uri = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=41.785841,-87.597256&radius=1000&types=cafe&sensor=false&key=AIzaSyAZO08sPxtMwOgkgrAVYdYbPqIm0FxQUwk"
    json = JSON.parse(open(uri).read)
  end
  
end