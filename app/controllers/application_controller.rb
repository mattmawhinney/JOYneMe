class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user
  around_filter :set_time_zone

  def current_user
  	@current_user ||= User.find_by(id: session[:user_id])
  end 

  def require_logged_in
  	if current_user
      true
    else 
       redirect_to root_path, notice: 'You must be logged in to see this page.'
    end 
    

   #  return true if current_user
  	#  redirect_to root_path 
  	# return false 
  end 

  def require_not_logged_in
    if !current_user
      true 
    else 
      redirect_to current_user
    end 
  end

  def restrict_to_current_user
    if current_user && current_user.id != params[:id].to_i 
      redirect_to user_path(current_user), notice: 'You may only see your page and edit your own profile.'
    end 
  end 


private
                                                                                 
  def set_time_zone
    old_time_zone = Time.zone
    Time.zone = browser_timezone if browser_timezone.present?
    yield
  ensure
    Time.zone = old_time_zone
  end
                                                                                   
  def browser_timezone
    cookies["browser.timezone"]
  end

end
