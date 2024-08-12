require 'rails_helper'

RSpec.describe ProfilesController do
  before(:each){ Profile.create(name: 'Teste 555', url: 'teste555') }
  before(:each){ Profile.create(name: 'Teste 777', url: 'teste777') }
  describe 'GET :index' do
    it 'returns profiles list' do
      get :index
      expect(response).to render_template('index')
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
      post :create, params:{profile: {name: 'Teste 999', url: 'teste999'}}
      expect(response).to redirect_to(profile_path(Profile.last))
      expect(assigns(:profile)).to eq(Profile.last)
    end
  end

  describe 'PUT :update' do
    it 'update one profile' do
      put :update, params: {id: Profile.first.id, profile: {name: 'Teste Modificado', url: 'Modificado'}}
      expect(response).to redirect_to(profile_path(Profile.first))
      expect(assigns(:profile)).to eq(Profile.first)
      expect(Profile.where(id: Profile.first.id).pluck(:url, :name).flatten).to include('https://github.com/Modificado', 'Teste Modificado')
    end
  end
end
