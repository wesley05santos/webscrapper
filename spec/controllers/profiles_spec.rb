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
end
