class UsersController < ApplicationController
  before_filter :correct_user, :only => [:edit, :update]
  
  def show
    @user = User.find_by_username(params[:username])
  end
  
  def edit
    @user = User.find_by_username(params[:username])
    @user.my_skills << MySkill.new
  end
  
  def update
    @user = User.find_by_username(params[:username])
    
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
    skills = Skill.pluck(:tag)
    respond_to do |format|
      format.js {render :json => skills}
    end
  end
  
end
