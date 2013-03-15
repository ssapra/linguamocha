class UsersController < ApplicationController
  before_filter :correct_user, :only => [:edit, :update]

  # before_filter :helpers, :only => [:show]

  # GET /:username
  def show
    @user = User.find_by_username(params[:username])
    @current_user = current_user
    @skill = MySkill.new
    @interest = Interest.new
  end

  # PUT /bio/
  def bio
    @user = current_user
    if params[:user][:bio] == ""
      bio = nil
    else
      bio = params[:user][:bio]
    end
    if @user.update_attributes(:bio => bio)
      respond_to do |format|
        format.html { redirect_to user_path(@user.username), notice: 'User was successfully updated.' }
        format.js { render "update_bio"}
      end
    end
  end

  def edit_bio
    @user = current_user
    params[:username] = @user.username

    respond_to do |format|
      format.js
    end
  end

  def remove_bio
    @user = current_user
    params[:username] = @user.username
    @user.update_attributes(:bio => nil)
    respond_to do |format|
      format.js
    end
  end

  # GET /:username/edit
  def edit
    @user = current_user
  end

  # PUT /:userame
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

  # GET /allskills
  def all_skills
    skills = CSV.read("skills.csv").flatten

    respond_to do |format|
      format.json {render :json => skills.to_json}
    end
  end

  # POST /full_search
  def search
    if params[:search]
      @params = params[:search]

      @users = []

      @params.split(" ").each do |param|
        @q = User.search({"first_name_cont"=>param.capitalize})
        @users << @q.result(:distinct => true)
        @q = User.search({"last_name_cont"=>param.capitalize})
        @users << @q.result(:distinct => true)
        @q = User.search({"my_skills_tag_cont"=>param.downcase})
        @users << @q.result(:distinct => true)
        @q = User.search({"interests_tag_cont"=>param.downcase})
        @users << @q.result(:distinct => true)
      end
      @users = @users.flatten.uniq.select{|user| user.id != current_user.id}
    elsif params[:q]
      @q = User.search(params[:q])
      @users = @q.result(:distinct => true)
      @users.select!{|user| user.id != current_user.id}
    end
  end

  # GET /full_search
  def search_form
    @search = User.search(params[:q])
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
