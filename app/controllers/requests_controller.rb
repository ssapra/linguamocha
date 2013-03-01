class RequestsController < ApplicationController
  include Places
  
  # before_filter :get_location
  # before_filter :get_coordinates
  
  before_filter :clear_messages, :only => [:show, :edit]
  
  def index
    @user = current_user
    @sent = @user.sent_requests
    @received = @user.received_requests
    @past_sent = @user.past_sent_requests
    @past_received = @user.past_received_requests
  end
  
  def new
    @request = Request.new(:sender_id => params[:sender_id], 
                          :receiver_id => params[:receiver_id])
    @request.messages << Message.new(:user_id => current_user.id)
    @receiver = User.find(params[:receiver_id]).name
  end
  
  def create
    @request = Request.new(params[:request])
    split_date = params[:request][:deadline].split("/")
    date = split_date[1] + "/" + split_date[0] + "/" + split_date[2]
    @request.deadline = Date.parse(date)
    # @request.times = Request.save_times(params[:times]) if params[:times]

    respond_to do |format|
      if @request.save
        @request.messages.last.update_attributes(:user_id => current_user.id)
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
    @message = Message.new(:request_id => @request.id)
    @review = @request.review
  end
  
  def edit
    @request = Request.find_by_id(params[:id])
    @location = get_location
    @coordinates = get_coordinates
    @days = (@request.deadline - Date.today).to_i

    @message = Message.new(:request_id => @request.id, :user_id => current_user.id)
    if @request.start_time then @start_time = @request.start_time.strftime("%l:%M %P") end
    if @request.end_time then @end_time = @request.end_time.strftime("%l:%M %P") end
  end
  
  def update
    @request = Request.find(params[:id])
    raw_request = params[:request]
    Request.update_location(@request, params[:location]) if params[:location]
    @request.update_attributes(:times => (Request.save_times(params[:times]))) if params[:times]

    message = params["request"]["messages_attributes"]
    body = message[message.keys[0]]["body"]
    Request.deal_with_message(@request, body, current_user.id)

    @request.update_attributes(:date => change_date(params[:date]),
                               :start_time => params[:start_time],
                               :end_time => params[:end_time]) if params[:date]

    respond_to do |format|
      if @request
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
    points = Places.businesses(params[:current_location])
    
    respond_to do |format|
      format.json {render :json => points.to_json}
    end
  end
  
  def coordinates
    points = Places.coordinates(params[:current_location])
    
    respond_to do |format|
      format.json {render :json => points.to_json}
    end
  end
  
  def my_coordinates
    @coordinates = get_coordinates
    logger.debug "coordites #{@coordinates}"
    if @coordinates == {:latitude => nil, :longitude => nil}
      @coordinates = {:latitude => 41.785935, :longitude =>  -88.147299}
    end
    
    respond_to do |format|
      format.json {render :json => @coordinates.to_json}
    end
  end
  
  def accept
    @request = Request.find(params[:id])
    @request.update_attributes(:receiver_confirmation => true)
    redirect_to edit_request_path(@request)
  end
  
  def deny
    @request = Request.find(params[:id])    
    @request.update_attributes(:receiver_confirmation => false)
    redirect_to @request
  end

  def confirm
    @request = Request.find(params[:id])
    @request.update_attributes(:sender_confirmation => true)
    redirect_to edit_request_path(@request)
  end

  def deny_request
    @request = Request.find(params[:id])    
    @request.update_attributes(:sender_confirmation => false)
    redirect_to @request
  end

  def load_times
    request_id = params[:request_id].to_i
    r = Request.find(request_id)
    times = []
    times = eval(r.times) if r.times
    respond_to do |format|
      format.json {render :json => times}
    end
  end
  
  def get_location
    results = search
    if results 
      @zipcode = results["zipcode"]
    else 
      nil
    end
  end
  
  def search
    @ip = request.remote_ip
    if @ip == '127.0.0.1' then @ip = '24.14.125.69' end
    if Geocoder.search(@ip)[0] != nil 
      results = Geocoder.search(@ip)[0].data 
    end
    logger.debug "results: #{results}"
    results
  end
  
  def get_coordinates
    results = search
    
    if results 
      @coordinates = {:latitude => results["latitude"].to_f,
                      :longitude => results["longitude"].to_f}
    else 
      nil
    end
    # logger.debug "Results: #{@coordinates}"
  end
  
  def clear_messages
    @request = Request.find(params[:id])
    @request.messages.each do |m|
      if m.body == nil || m.body == "" then m.destroy end
    end
  end
  
end