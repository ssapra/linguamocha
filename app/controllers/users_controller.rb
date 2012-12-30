class UsersController < ApplicationController
  before_filter :correct_user, :only => [:edit, :update]
  
  def show
    @user = User.find_by_username(params[:username])
    @current_user = current_user
    @education = [@user.high_school, @user.college, @user.degree]
    @ip = request.remote_ip
    if Geocoder.search(@ip)[0] != nil then results = Geocoder.search(@ip)[0].data end
    if results 
      @location = results["city"] + ", " + results["region_code"]
    end
    logger.debug "Results: #{@location}"
  end
  
  def edit
    @user = current_user
  end
  
  def update
    @user = current_user
    
    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to user_path(@user.username), notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def all_skills
    skills = CSV.read("skills.csv").flatten
  
    respond_to do |format|
      format.json {render :json => skills.to_json}
    end
  end
  
end
