require 'unirest'
class UsersController < ApplicationController
    before_action :logged_in_user, :find_and_ensure_user, only: [:show, :edit, :update]
    before_action :correct_user, only: [:show, :edit, :update]

  def new
    @user = User.new
  end

  def create
    user = User.new(user_params)
    if user.save
      session[:user_id] = user.id
      flash[:success] = "You're almost there! Please tell us a little more about yourself." # This needs to be styled, otherwise, let's remove it
      redirect_to new_user_profile_path(user)
    else
      @errors = user.errors.full_messages
      render 'new'
    end
  end

  def show
    # user and match below need to be updated
    user = User.first
    match = User.third
    @midpoint = find_midpoint(user, match)
    # binding.pry
    # runs_by_date = @user.runs.where("run_date > ?", DateTime.now)
    # results = {}
    # runs_by_date.each { |run| results[run] = Time.at(run.time).utc.strftime('%H:%M:%S').in_time_zone("Eastern Time (US & Canada)") } #can we find the differnce between the date that line 27 returns and add the difference to the time objects?
    # @upcoming_runs = results.select { |k, v| v < DateTime.now }.keys #this might have to be reversed with the greater_than or less_than operator
  end

  def edit
  end


  def update

  end

  private
    def find_and_ensure_user
      render 'application/error_404' unless @user = User.find_by(id: params[:id])
    end

    def user_params
      params.require(:user).permit(:name, :email, :zipcode, :latitude, :longitude, :password, :password_confirmation)
    end

    def find_midpoint(user, match)
      midpoint = [(user.latitude + match.latitude) / 2 , (user.longitude + match.longitude) / 2 ]
    end
end
