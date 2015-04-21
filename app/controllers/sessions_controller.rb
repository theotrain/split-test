class SessionsController < ApplicationController
  def new

  end

  def create
    user = User.find_by_email(params[:email])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:notice]    = "Welcome, #{user.screen_name}!"
      redirect_to home_path
    else
      flash[:error]     = "There's something wrong with your username or password"
      redirect_to sign_in_path
    end

  end

  def destroy
    session[:user_id] = nil
    flash[:notice]    = "Logged out."
    redirect_to sign_in_path
  end
end