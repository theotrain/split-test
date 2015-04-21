class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "You successfully registered and are now signed in, #{@user.screen_name}."
      redirect_to home_path
    else
      render :new
    end
  end

  def user_params
    params.require(:user).permit(:email, :password, :screen_name)
  end

end