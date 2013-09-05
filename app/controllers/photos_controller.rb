class PhotosController < ApplicationController
  def new
    @photo = Photo.new
  end

  def create
    @photo = Photo.new photo_params

    return redirect_to root_path if @photo.save

    render :new
  end

  private
  def photo_params
    params.require(:photo).permit :title, :description, :tags
  end
end
