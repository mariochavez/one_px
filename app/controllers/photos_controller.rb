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

    return redirect_to photos_path if @photo.save

    render :new
  end

  def edit
    respond_with @photo
  end

  def update
    if @photo.update_attributes photo_params
      return redirect_to photos_path, notice: 'Tu foto fue actualizada'
    end

    render :edit
  end

  def destroy
    @photo.destroy

    redirect_to photos_path, notice: 'Su foto fue eliminada'
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
