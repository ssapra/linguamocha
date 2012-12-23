class MessagesController < ApplicationController
  
  def create
    message = Message.new(params[:message])
    message.user_id = current_user.id
    @request = message.request
    respond_to do |format|
      if message.save
        format.html { redirect_to @request, notice: 'Message was successfully created.' }
        format.json { render json: @message, status: :created, location: @message }
        format.js
      else
        format.html { render action: "new" }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end
  
end