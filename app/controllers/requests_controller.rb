class RequestsController < ApplicationController
  
  def index
    user = User.find_by_username(params[:username])
    @requests = user.requests
  end
  
end