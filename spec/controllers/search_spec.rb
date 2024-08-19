require 'rails_helper'

RSpec.describe SearchController do

  before(:each) do
    Profile.create(name: 'wesley', url: 'https://github.com/wesley05')
    Profile.create(name: 'EDSON', url: 'https://github.com/EDSON')
    Profile.create(name: 'Fulano', url: 'https://github.com/fulano01')
    Profile.create(name: 'Ciclano', url: 'https://github.com/ciclano05')
  end

  describe 'GET :search_profiles' do
    it 'render all profiles' do
      get :search_profiles
      expect(response).to render_template('search_profiles')
      expect(assigns(:profiles).length).to eq(4)
    end

    it 'search profiles fill in with letters "ano" ' do
      get :search_profiles, params: {query: 'ano'}
      expect(response).to render_template('search_profiles')
      expect(assigns(:profiles).pluck(:name)).to include('Fulano', 'Ciclano')
    end

    it 'search profiles fill in with letter "e" ' do
      get :search_profiles, params: {query: 'e'}
      expect(response).to render_template('search_profiles')
      expect(assigns(:profiles).pluck(:name)).to include('wesley', 'EDSON')
    end

    it 'search profiles fill in with number "5" ' do
      get :search_profiles, params: {query: '5'}
      expect(response).to render_template('search_profiles')
      expect(assigns(:profiles).pluck(:name)).to include('wesley', 'Ciclano')
    end
  end
end
