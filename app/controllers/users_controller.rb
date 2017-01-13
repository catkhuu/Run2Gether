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
      flash[:success] = "You're almost there! Please tell us a little more about yourself."
      redirect_to new_user_profile_path(user)
    else
      @user = User.new
      @errors = user.errors.full_messages
      render 'new'
    end
  end

  def show
    users_runs = Run.run_history(current_user)
    @past_runs = Run.past_runs(users_runs)
    @upcoming_runs = Run.upcoming_runs(users_runs)
    if @upcoming_runs.empty? || @upcoming_runs.first.companion_id == nil
      @meetingpoint = [current_user.latitude, current_user.longitude]
    else
      next_run = @upcoming_runs.first
      @meetingpoint = [next_run.latitude, next_run.longitude]
    end
  end

  def updatemap
    @run = Run.find(params[:run_id])

    @meetingpoint = [@run.latitude, @run.longitude]
    if request.xhr?
      render json: @meetingpoint
    end
  end

  private
    def find_and_ensure_user
      render 'application/error_404' unless @user = User.find_by(id: params[:id])
    end

    def user_params
      params.require(:user).permit(:name, :email, :zipcode, :latitude, :longitude, :password, :password_confirmation)
    end
end
