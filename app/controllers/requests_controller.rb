class RequestsController < ApplicationController
  
  before_filter :get_location
  
  def index
    @user = current_user
    @sent = @user.sent_requests
    @received = @user.received_requests
  end
  
  def new
    @request = Request.new(:sender_id => params[:sender_id], 
                          :receiver_id => params[:receiver_id])
    @request.messages << Message.new
  end
  
  def create
    @request = Request.new(params[:request])
    split_date = params[:request][:date].split("/")
    date = split_date[1] + "/" + split_date[0] + "/" + split_date[2]
    @request.date = Date.parse(date)

    respond_to do |format|
      if @request.save
        @request.messages.last.update_attributes(:user_id => current_user.id)
        if params[:location] then @request.update_attributes(:location => params[:location]) end
        format.html { redirect_to @request, notice: 'Note was successfully created.' }
        format.json { render json: @request, status: :created, location: @request }
      else
        format.html { render action: "new" }
        format.json { render json: @request.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def show
    @request = Request.find_by_id(params[:id])
  end
  
  def edit
    @request = Request.find_by_id(params[:id])
    @message = Message.new(:request_id => @request.id)
  end
  
  def update
    @request = Request.find(params[:id])
    
    params[:request][:date] = change_date(params[:request][:date])
    respond_to do |format|
      if @request.update_attributes(params[:request])
        if params[:location] then @request.update_attributes(:location => params[:location]) end
        format.html { redirect_to @request, notice: 'Request was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @request.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def change_date(stringdate)
    split = stringdate.split("")
    if split.include?("/")
      Date.strptime(stringdate,"%m/%d/%Y")
    else
      Date.strptime(stringdate,"%Y-%m-%d")
    end
  end
  
  def nearby_locations
    consumer_key = 'EcxkaDnICiYJE2PZm_OeCw'
    consumer_secret = 'Yqc_OOMULadnzTs7Juj8bmZN3Ng'
    token = 'sKXNbkV6k17LqXx3Rjl21BzvpP26O9CF'
    token_secret = '8EuUtxYMsqGD89qtIRkDj-LOXKg'

    api_host = 'api.yelp.com'

    consumer = OAuth::Consumer.new(consumer_key, consumer_secret, {:site => "http://#{api_host}"})
    access_token = OAuth::AccessToken.new(consumer, token, token_secret)
    
    cl = params[:current_location].split(" ").join("+")

    path = "/v2/search?term=cafe+coffee&location=#{cl}"

    string =  access_token.get(path).body

    json = JSON.parse(string)
    
    points = []

    json["businesses"].each do |business|
      points << {:name => business["name"], :address => business["location"]["address"][0]}
    end
    
    respond_to do |format|
      format.json {render :json => points.to_json}
    end
  end
  
end