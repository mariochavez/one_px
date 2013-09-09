class UsersController < ApplicationController
  before_action :redirect_already_logged_user

  def new
    @user = User.new

    respond_with @user
  end

  def create
    @user = User.new user_params

    location = if @user.save
      session[:user] = @user.id
      flash[:notice] = 'Welcome aboard'
      root_path
    end

    respond_with @user, location: location
  end

  private
  def redirect_already_logged_user
    redirect_to root_path if current_user?
  end

  def user_params
    params.require(:user).permit :email, :password, :password_confirmation
  end
end
