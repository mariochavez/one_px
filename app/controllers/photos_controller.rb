class PhotosController < ApplicationController
  before_action :authenticate!
  before_action :find_resource, only: [ :show, :edit, :update, :destroy ]

  def index
    @photos = Photo.get_by_user_eager(current_user.id).desc_id_ordered

    respond_with @photos
  end

  def show
    respond_with @photo
  end

  def new
    @photo = Photo.new

    respond_with @photo
  end

  def create
    @photo = Photo.new(photo_params).tap do |photo|
      photo.user = current_user
    end

    location = if @photo.save && params[:format].nil?
      flash[:notice] = 'Una nueva foto ha sido creada'
      photos_path
   end

    respond_with @photo, location: location
  end

  def edit
    respond_with @photo
  end

  def update
    location = if @photo.update_attributes(photo_params) && params[:format].nil?
      flash[:notice] = 'Tu foto fue actualizada'
      photos_path
    end

    respond_with @photo, location: location
  end

  def destroy
    @photo.destroy

    location = if params[:format].nil?
      flash[:notice] = 'Su foto fue eliminada'
      photos_path
    end

    respond_with @photo, location: location
  end

  private
  def find_resource
    @photo = Photo.get_by_id_and_user(params[:id], current_user.id).first

    return redirect_to root_path, alert: t(:record_not_found) unless @photo
  end

  def photo_params
    params.require(:photo).permit :title, :description, :tags, :image
  end
end
