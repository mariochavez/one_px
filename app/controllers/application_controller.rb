class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :set_locale

  def current_user?
    session[:user].present?
  end

  def current_user
    @current_user ||= User.find_by_id session[:user] if current_user?
  end

  helper_method :current_user?, :current_user

  def authenticate!
    redirect_to signin_path unless current_user?
  end

  protected
  def set_locale
    if params.has_key? :lang
      locale = params[:lang].to_s.to_sym

      if %I(es en).include? locale
        I18n.locale = locale
      end
    end

    #I18n.locale = request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first
  end
end
