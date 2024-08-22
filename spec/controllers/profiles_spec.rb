require 'rails_helper'

RSpec.describe ProfilesController do
  before(:each){ Profile.create(name: 'Wesley', url: 'wesley05santos') }
  before(:each){ Profile.create(name: 'Xita', url: 'xitarps') }
  describe 'GET :index' do
    it 'returns profiles list' do
      get :index
      expect(response).to render_template('index')
    end
  end

  describe 'GET :new' do
    it 'returns profiles list' do
      get :new
      expect(response).to render_template('new')
    end
  end

  describe 'GET :show' do
    it 'returns one profile' do
      get :show, params: {id: Profile.first.id}
      expect(response).to render_template('show')
      expect(assigns(:profile)).to eq(Profile.first)
    end
  end

  describe 'POST :create' do
    it 'create one profile' do
      post :create, params:{profile: {name: 'Matz', url: 'matz'}}
      expect(response).to redirect_to(profile_path(Profile.last))
      expect(assigns(:profile)).to eq(Profile.last)
    end

    it 'error to create one profile missing name' do
      post :create, params:{profile: {name: '', url: 'matz'}}
      expect(response.status).to eq(422)
    end

    it 'error to create one profile missing url' do
      post :create, params:{profile: {name: 'Matz', url: ''}}
      expect(response.status).to eq(422)
    end
  end

  describe 'PUT :update' do
    it 'update one profile' do
      put :update, params: {id: Profile.first.id, profile: {name: 'Matz', url: 'matz'}}
      expect(response).to redirect_to(profile_path(Profile.first))
      expect(assigns(:profile)).to eq(Profile.first)
      expect(Profile.where(id: Profile.first.id).pluck(:url, :name).flatten).to include('https://github.com/matz', 'Matz')
    end

    it 'error to create one profile missing name' do
      put :update, params: {id: Profile.first.id, profile: {name: '', url: 'matz'}}
      expect(response.status).to eq(422)
    end

    it 'error to create one profile missing url' do
      put :update, params: {id: Profile.first.id, profile: {name: 'Matz', url: ''}}
      expect(response.status).to eq(422)
    end
  end

  describe 'DELETE :destroy' do
    it 'destroy one profile' do
      delete :destroy, params: {id: Profile.first.id}
      expect(response).to redirect_to(profiles_path)
      expect(Profile.pluck(:name).flatten).not_to include('Wesley')
    end
  end

  describe 'PUT :rescan' do
    it 'rescan profile' do
      Profile.first.update(stars: 39)
      put :rescan, params: {profile_id: Profile.first.id}
      expect(Profile.first.stars).not_to eq(39)
    end
  end
end
