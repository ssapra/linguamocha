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
    @ip = request.remote_ip
    if Geocoder.search(@ip)[0] != nil then results = Geocoder.search(@ip)[0].data end
    if results 
      @location = results["city"] + ", " + results["region_code"]
    else 
      nil
    end
    logger.debug "Results: #{@location}"
  end
  
end
