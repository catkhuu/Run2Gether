class RunsController < ApplicationController
  include RunsHelper
  before_action :sanitize_params, only: [:create, :update]

  def new
    @run = Run.new
    if request.xhr?
      render 'new', layout: false
    end
  end

  def create
    @run = Run.new(run_params)
    if @run.save
      users_runs = Run.all.select { |run| run.runner_id == current_user.id ||      run.companion_id == current_user.id }
      @upcoming_runs = users_runs.select { |run| run.converted_date > DateTime.now }
      if request.xhr?
        render partial: 'users/upcoming_runs', layout: false, locals: {upcoming_runs: @upcoming_runs}
      else
        @errors = @run.errors.full_messages.to_json
        render :json => @errors
      end
    end
  end

  def new_search
    if request.xhr?
      render 'new_search', layout: false
    end
  end

  def search
    temporary_run = Run.create(run_params)
    by_proximity = Run.near([temporary_run.latitude, temporary_run.longitude],1,:order => :distance)
    by_date = by_proximity.where(run_date: temporary_run.run_date)
    search_results = by_date.select { |run| run.runner.profile.experience == current_user.profile.experience }

    @final = search_results.select {|run| run.companion_id == nil && run.runner_id != current_user.id }.sample

    if @final
      render 'users/_match', layout: false, locals: { final: @final }
    else
      render 'users/_no_match', layout: false
    end
  end

  def show
  end

  def edit
  end

  def update
  end
  def add_companion
    if run = Run.where(id: params[:run_id]).update(companion_id: current_user.id)
      users_runs = Run.all.select { |run| run.runner_id == current_user.id || run.companion_id == current_user.id }
      @upcoming_runs = users_runs.select { |run| run.converted_date > DateTime.now }
      if request.xhr?
        render partial: 'users/upcoming_runs', layout: false, locals: {upcoming_runs: @upcoming_runs}
      else
        redirect_to users_path(current_user.id)
      end
    else
      error = { fail: 'Update unsuccessful. Try again.' }.to_json
      render :json => error
    end
  end

  def edit_stats
    @run = Run.find_by(id: params[:run_id])
  end

  def update_stats
    @run = Run.find_by(id: params[:run_id])
    if @run.update(stats_params)
      redirect_to user_path(@run.runner_id)
    else
      render 'edit_stats'
    end
  end


  private

  def stats_params
    params.require(:run).permit(:distance, :run_time, :run_pace)
  end

  def run_params
    params.require(:run).permit(:run_date, :time, :zipcode, :runner_id, :desired_distance)
  end

  def find_and_ensure_run
    render 'application/error_404' unless @run = current_user.runs.find_by(id: params[:id])
  end

  def sanitize_params
    if params[:run][:run_daypart] == 'PM'
      params[:run][:run_hours] = params[:run][:run_hours].to_i + 12
    end
    hr_sec = convert_hours_to_seconds(params[:run][:run_hours])
    min_sec = convert_minutes_to_seconds(params[:run][:run_minutes])
    params[:run][:time] = hr_sec + min_sec
    params[:run][:runner_id] = current_user.id
  end
end
