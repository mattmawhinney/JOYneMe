class SessionsController < ApplicationController
  def new
  end

  def create
  	@user = User.find_by(username: params[:username]).try(:authenticate, params[:password])

  	if @user
  		session[:user_id] = @user.id
  		redirect_to user_path(@user), notice: 'User logged in successfully!'
  	else 
  		render :new
    end
  end
end