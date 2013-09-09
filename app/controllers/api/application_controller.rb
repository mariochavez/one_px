module Api
  class ApplicationController < ActionController::Base
    before_action :set_locale
    respond_to :json, :xml

    protected
    def get_authorization
      @token ||= request.headers['Auth-Token'].to_s
      @authorization ||= Authorization.find_by(token: @token) if @token
    end

    private
    def get_auth_header
      authorization = get_authorization

      unless authorization
        return render json: { message: 'Not authorized' }, status: 401
      end

      if authorization && DateTime.now > authorization.expiration
        return render json: { message: 'Token expired' }, status: 401
      end
    end

    def set_locale
      I18n.locale = :en
    end
  end
end
