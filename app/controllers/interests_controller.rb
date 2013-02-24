class InterestsController < ApplicationController

	def create
	  @interest = Interest.new(params[:interest])
	  @interest.user_id = current_user.id
      @user = current_user
      logger.debug "#{@interest.inspect}"
      respond_to do |format|
	    if @interest.save
	      format.html { redirect_to @user, notice: 'Interest was successfully created.' }
	      format.json { render json: @interest, status: :created, location: @interest }
	      format.js
	    else
	      logger.debug "Not saving"
	      format.html { render action: "new" }
	      format.json { render json: @interest.errors, status: :unprocessable_entity }
	    end
	  end
	end


	def edit
		@interest = Interest.find(params[:id])
    
    respond_to do |format|
      format.html
      format.js
    end
	end

	def update
		@interest = Interest.find(params[:id])
    
    respond_to do |format|
      if @interest.update_attributes(params[:interest])
        format.html { redirect_to @interest, notice: 'Interest was successfully updated.' }
        format.json { head :no_content }
        format.js
      else
        format.html { render action: "edit" }
        format.json { render json: @interest.errors, status: :unprocessable_entity }
      end
    end
	end

	def destroy
		@interest = Interest.find(params[:id])
    @interest.destroy

    respond_to do |format|
      format.html { redirect_to current_user }
      format.json { head :no_content }
      format.js
    end
	end

end