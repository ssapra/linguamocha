class ApplicationController < ActionController::Base
  protect_from_forgery
  
  protected
  
  def correct_user    
    if(params[:username])
      unless current_user == User.find_by_username(params[:username]) 
        flash[:error] = "Unauthorized Access"
        redirect_to root_path
        false
      end
    end
  end
  
  def get_location
    results = search
    if results 
      @location = results["city"] + ", " + results["region_code"]
    else 
      nil
    end
    logger.debug "Results: #{@location}"
  end
  
  def search
    @ip = request.remote_ip
    if @ip == '127.0.0.1' then @ip = '24.14.125.69' end
    if Geocoder.search(@ip)[0] != nil 
      results = Geocoder.search(@ip)[0].data 
    end
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
    logger.debug "Results: #{@coordinates}"
  end
  
end