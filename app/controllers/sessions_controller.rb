class SessionsController < ApplicationController

  def new
    @user = User.new
    respond_with @user
  end

  def create
    @user = User.find_by(email: user_params[:email]).try(:authenticate, user_params[:password])

    if @user
      flash[:notice] = 'Bienvenido'
      session[:user] = @user.id
      location = root_path
    else
      flash[:alert] = 'Credenciales invalidas'
      @user = User.new email: user_params[:email]
      @user.errors.add(:base, 'Credenciales invalidas')
      #@user.errors.add(:email, 'es requerido') if user_params[:email].blank?
    end

    respond_with @user, location: location
  end

  def destroy
    session[:user] = nil
    redirect_to root_path
  end

  private
  def user_params
    params.require(:user).permit :email, :password
  end
end
