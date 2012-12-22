class RequestsController < ApplicationController
  
  def index
    user = User.find_by_username(params[:username])
    @requests = user.requests
  end
  
  def new
    @request = Request.new(:sender_id => params[:sender_id], 
                          :receiver_id => params[:receiver_id])
    @request.messages << Message.new
  end
  
  def create
    @request = Request.new(params[:request])
    
    respond_to do |format|
      if @request.save
        format.html { redirect_to @request, notice: 'Note was successfully created.' }
        format.json { render json: @request, status: :created, location: @request }
        format.js
      else
        format.html { render action: "new" }
        format.json { render json: @request.errors, status: :unprocessable_entity }
      end
    end
  end
  
  # def show
  #   @request = Request.
  # end
  
end