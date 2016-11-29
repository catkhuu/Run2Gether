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
    users_runs = Run.all.select { |run| run.runner_id == current_user.id || run.companion_id == current_user.id }
    @past_runs = users_runs.select { |run| run.converted_date < DateTime.now }
    @upcoming_runs = users_runs.select { |run| run.converted_date > DateTime.now }
    if @upcoming_runs.empty? || @upcoming_runs.first.companion_id == nil
      @meeting_point = [current_user.latitude, current_user.longitude]
    else
      user = current_user
      next_run = @upcoming_runs.first
      @midpoint = [@upcoming_runs.first.latitude, @upcoming_runs.first.longitude]
    end
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

    def find_midpoint(user, next_run)
      midpoint = [(user.latitude + next_run.latitude) / 2 , (user.longitude + next_run.longitude) / 2 ]
    end
end
