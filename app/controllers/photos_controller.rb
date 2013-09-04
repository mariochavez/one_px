class PhotosController < ApplicationController
  def new
    @photo = Photo.new
  end

  def create
    @photo = Photo.new photo_params
    @photo.save

    redirect_to root_path
  end

  private
  def photo_params
    params.require(:photo).permit :title, :description, :tags
  end
end
