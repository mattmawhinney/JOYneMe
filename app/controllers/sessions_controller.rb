class SessionsController < ApplicationController
  before_action :require_not_logged_in, only: [:new, :create]
  
  def new
  end

  def create
  	@user = User.find_by(username: params[:username]).try(:authenticate, params[:password])
  	if @user
  		session[:user_id] = @user.id
  		redirect_to user_path(current_user), notice: 'User logged in successfully!'
  	else 
  		redirect_to root_path, notice: 'Incorrect username/password combination.'
    end
  end

  def destroy 
    session.delete :user_id
    redirect_to root_path, notice: 'You have sucessfully logged out.'
  end

end