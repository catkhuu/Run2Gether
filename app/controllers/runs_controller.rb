class RunsController < ApplicationController
  include RunsHelper
  before_action :sanitize_params, only: [:create, :update]
  # before_action :find_and_ensure_run, only: [:upvote, :declines]

  def new
    @run = Run.new
    if request.xhr?
      render 'new', layout: false
    end
  end

  def create
    @run = Run.new(run_params)
    # debugger
      if @run.save
        #   zipcode_list = retrieve_zipcodes_within_radius(@run.zipcode)
        #   matchers = search_by_date_time(zipcode_list, @run)
        #   flash[:success] = "Run saved."
        #   render partial: 'runs/run', layout: false, locals: { run: @run }

      # flash[:success] = "Run saved."
         # redirect_to user_path(current_user.id)
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
      by_proximity_and_date = Run.near([current_user.latitude, current_user.longitude],1,:order => :distance)

      search_results = by_proximity_and_date.select { |run| run.runner.profile.experience == current_user.profile.experience }
      @final = search_results.select {|run| run.companion_id == nil}.sample
      # render :json => @final.first
      render 'users/_match', locals: { final: @final }
  end

  def show
  end

  def edit
  end

  def update
  end
  def add_companion
    if run = Run.where(id: params[:run_id]).update(companion_id: current_user.id)
      success = { success: "Run added to your upcoming runs. Enjoy your run with #{run[0].runner.name}" }.to_json
      render :json => success

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
