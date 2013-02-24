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


	def edit
		@skill = MySkill.find(params[:id])
    
    respond_to do |format|
      format.html
      format.js
    end
	end

	def update
		@skill = MySkill.find(params[:id])
    
    respond_to do |format|
      if @skill.update_attributes(params[:my_skill])
        format.html { redirect_to @skill, notice: 'Skill was successfully updated.' }
        format.json { head :no_content }
        format.js
      else
        format.html { render action: "edit" }
        format.json { render json: @skill.errors, status: :unprocessable_entity }
      end
    end
	end

	def destroy
		@skill = MySkill.find(params[:id])
    @skill.destroy

    respond_to do |format|
      format.html { redirect_to current_user }
      format.json { head :no_content }
      format.js
    end

	end

end