module Api
  class AuthenticationController < Api::ApplicationController
    def create
      @authorization = get_authorization

      status = 200

      if not @authorization or (@authorization && Time.now > @authorization.expiration)
        user = ::User.find_by(email: params[:email]).try(:authenticate, params[:password])

        if user
          @authorization = Authorization.create token: SecureRandom.hex(15),
            expiration: Time.now + 8.days, user: user
        else
          @authorization = { message: 'Invalid credentials' }
          status = 401
        end
      end

      respond_with @authorization, status: status, location: ''
    end
  end
end
