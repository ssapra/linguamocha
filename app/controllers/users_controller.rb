class UsersController < ApplicationController
  before_filter :correct_user, :only => [:edit, :update]
  
  # before_filter :helpers, :only => [:show]
  
  def show
    @user = User.find_by_username(params[:username])
    @current_user = current_user
    @education = [@user.high_school, @user.college, @user.degree]
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
  
  def search
    @params = params[:search]
    
    @users = []
    
    @params.split(" ").each do |param|
      @users << User.where("first_name = ? OR last_name = ?", param, param)
    end
    
    @users.flatten!.uniq
    
  end
  
  def helpers
    @user = current_user
    
    all_searches = []
    
    @user.interests.each do |interest|
      
      search = User.search do
                 fulltext interest.tag
               end
      all_searches << search.results
    end
    
    logger.debug "#{all_searches}"
    
    @helpers = all_searches.flatten
  end
  
end
