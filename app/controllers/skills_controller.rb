class SkillsController < ApplicationController

	def create
	  @skill = MySkill.new(params[:my_skill])
	  @skill.user_id = current_user.id
      @user = current_user
      logger.debug "#{@skill.inspect}"
      respond_to do |format|
	    if @skill.save
	      format.html { redirect_to @user, notice: 'Skill was successfully created.' }
	      format.json { render json: @skill, status: :created, location: @skill }
	      format.js
	    else
	      logger.debug "Not saving"
	      format.html { render action: "new" }
	      format.json { render json: @skill.errors, status: :unprocessable_entity }
	    end
	  end
	end

end