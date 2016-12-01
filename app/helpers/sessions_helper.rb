module SessionsHelper
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !current_user.nil?
  end

  def current_user?
    find_and_ensure_user
    @user == current_user
  end

  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = 'Login before viewing content'
      redirect_to new_session_path
    end
  end

  def has_profile?
    !!current_user.profile
  end

  def correct_user
    render 'application/error_404' unless current_user?
  end

  def redirect_back_or(default)
    redirect_to(session[:forarding_url] || default)
    session.delete(:forarding_url)
  end

  def store_location
    session[:forarding_url] = request.original_url if request.get?
  end

  def load_profile_picture
    if current_user.profile
      current_user.profile.avatar.url(:thumb)
    else
      profile_picture = 'http://www.freeiconspng.com/uploads/shoe-icon-27.png'
    end
  end

  def create_or_view_profile
    if current_user.profile
      "/users/#{current_user.id}/profiles/#{current_user.profile.id}"
    else
      "/users/#{current_user.id}/profiles/new"
    end
  end
end
