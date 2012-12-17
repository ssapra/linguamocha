class UsersController < ApplicationController
  def show
    @user = User.find_by_id(params[:id])
  end
  
  def edit
    @user = User.find_by_id(params[:id])
    @user.my_skills << MySkill.new
  end
  
  def update
    @user = User.find(params[:id])
    
    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
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
