class SessionsController < ApplicationController
  def new
  end

  def create
  	@user = User.find_by(username: params[:username]).try(:authenticate, params[:password])

  	if @user
  		session[:user_id] = @user.id
  		redirect_to events_path, notice: 'User logged in successfully!'
  	else 
  		render :new
    end
  end


  def destroy 
    session.clear
    redirect_to root_path
    # @user.destroy
    # respond_to do |format|
    #   format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
    #   format.json { head :no_content }
    # end
  end



end