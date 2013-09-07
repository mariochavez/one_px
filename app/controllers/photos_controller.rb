class PhotosController < ApplicationController
  before_action :find_resource, only: [ :show, :edit, :update, :destroy ]
  skip_before_action :verify_authenticity_token, :if => Proc.new { |c| c.request.format == 'application/json' }

  respond_to :html
  respond_to :json, :xml, except: [ :new, :edit ]

  def index
    @photos = Photo.all.order 'id desc'

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
    @photo = Photo.new photo_params

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
    @photo = Photo.find_by_id params[:id]

    return redirect_to root_path, alert: t(:record_not_found) unless @photo
  end

  def photo_params
    params.require(:photo).permit :title, :description, :tags
  end
end
