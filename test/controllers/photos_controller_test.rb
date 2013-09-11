require 'test_helper'

describe PhotosController do
  before do
    ApplicationController.class_eval do
      def current_user?
        true
      end

      def current_user
        @current_user ||= User.find 1
      end
    end
  end

  describe 'GET :index' do
    it 'set photos variable and respond ok' do
      get :index

      assert_response :success
      assert_template :index
      assert_not_nil assigns(:photos)
    end
  end

  describe 'GET :show' do
    it 'set photo variable and respond ok' do
      get :show, id: 1

      assert_response :success
      assert_template :show
      assert_not_nil assigns(:photo)
    end
  end

  describe 'POST :create' do
    it 'creates a new resource' do
      post :create, photo: {title: 'My pic', description: 'My pic', tags: 'test'}

      assert_redirected_to photos_path
      assert_not_nil flash[:notice]
    end

    it 'failed to create a new resource if params are invalid' do
      post :create, photo: {title: '', description: '', tags: ''}

      assert_response :success
      assert_template :new
      assert_nil flash[:notice]
      end
  end
end
