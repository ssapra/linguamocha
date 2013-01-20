class ReviewsController < ApplicationController
  
  def new
    @request = Request.find(params[:id])
    @review = Review.new(:request_id => @request.id,
                         :sender_id => @request.sender_id,
                         :receiver_id => @request.receiver_id)
  end
  
  def create
    @review = Review.new(params[:review])
    
    respond_to do |format|
      if @review.save
        
        format.html { redirect_to @review.request, notice: 'Review was successfully created.' }
        format.json { render json: @review, status: :created, location: @review }
      else
        format.html { render action: "new" }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end
  
end