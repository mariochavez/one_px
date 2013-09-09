module Api
  class PhotosController < Api::ApplicationController
    before_action :get_auth_header

    def index
      @photos = Photo.get_by_user_eager(current_user.id).desc_id_ordered

      respond_with @photos
    end

    private
    def current_user
      @authorization.user
    end
  end
end
