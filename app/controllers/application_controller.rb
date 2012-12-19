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
  
end
