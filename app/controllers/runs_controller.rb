class RunsController < ApplicationController
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
      users_runs = Run.run_history(current_user)
      @upcoming_runs = Run.upcoming_runs(users_runs)
      if request.xhr?
        render partial: 'users/upcoming_runs', layout: false, locals: { upcoming_runs: @upcoming_runs }
      else
        redirect_to users_show_path(current_user)
      end
    else
      @errors = @run.errors.full_messages
      if request.xhr?
        render json: { errors: @errors }, status: 422
      else
        render 'new'
      end
    end
  end

  def new_search
    if request.xhr?
      render 'new_search', layout: false
    end
  end

  def search
    searched_run = Run.create(run_params)
    nearby_runs = Run.nearby_runs(searched_run)
    runs_on_date = Run.runs_on_date(searched_run, nearby_runs)
    my_level_runs = Run.runs_by_experience(runs_on_date, current_user)
    ################################################################################
    #FIXME: For some reason, when no result is found, the no_match partial is not returned. Instead, user will receive a 500 error. Take a look at @final and what is returned. Page does NOT break. It doesn't return the correct partial.
    ################################################################################
    @final = Run.search_results(my_level_runs, current_user).sample
    if @final
      if request.xhr?
        render 'users/_match', layout: false, locals: { final: @final }
      else
        render 'users/_match', locals: { final: @final }
      end
    else
      if request.xhr?
        render 'users/_no_match', layout: false
      else
        @errors = { my_error: 'Sorry we are experiencing techincal difficulties' }
        render 'new_search'
      end
    end
  end

  def add_companion
    if run = Run.where(id: params[:run_id]).update(companion_id: current_user.id)
      users_runs = Run.run_history(current_user)
      @upcoming_runs = Run.upcoming_runs(users_runs)
      if request.xhr?
        render partial: 'users/upcoming_runs', layout: false, locals: { upcoming_runs: @upcoming_runs }
      else
        redirect_to users_path(current_user.id)
      end
    else
      if request.xhr?
      @error = { fail: 'Update unsuccessful. Try again.' }.to_json
      render :json => error
      else
        @errors = @run.errors.full_messages
        render 'new'
      end
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
      params[:run][:run_hours] = offset_time(params[:run][:run_hours])
    end
    params[:run][:time] = helpers.convert_time(params[:run][:run_hours], params[:run][:run_minutes])
    params[:run][:runner_id] = current_user.id
  end
end
