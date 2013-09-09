module Api
  class PhotosController < Api::ApplicationController

    def index
      @photos = Photo.get_by_user_eager(1).desc_id_ordered

      respond_with @photos
    end
  end
end
