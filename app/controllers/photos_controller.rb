class PhotosController < ApplicationController
  before_action :find_resource, only: :show

  def show
    redirect_to root_path, alert: 'Registro no encontrado' unless @photo
  end

  def new
    @photo = Photo.new
  end

  def create
    @photo = Photo.new photo_params

    return redirect_to root_path if @photo.save

    render :new
  end

  private
  def find_resource
    @photo = Photo.find_by_id params[:id]
  end

  def photo_params
    params.require(:photo).permit :title, :description, :tags
  end
end
