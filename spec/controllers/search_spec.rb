require 'rails_helper'

RSpec.describe SearchController do

  before(:each) do
    Profile.create(name: 'Wesley', url: 'https://github.com/wesley05santos')
    Profile.create(name: 'Xita', url: 'https://github.com/xitarps')
    Profile.create(name: 'Matz', url: 'https://github.com/matz')
  end

  describe 'GET :search_profiles' do
    it 'all profiles' do
      get :search_profiles
      expect(response).to render_template('search_profiles')
      expect(assigns(:profiles).length).to eq(3)
    end

    it 'fill in with letters "ano" ' do
      get :search_profiles, params: {query: 't'}
      expect(response).to render_template('search_profiles')
      expect(assigns(:profiles).pluck(:name)).to include('Wesley', 'Xita', 'Matz')
    end

    it 'fill in with letter "e" ' do
      get :search_profiles, params: {query: 'e'}
      expect(response).to render_template('search_profiles')
      expect(assigns(:profiles).pluck(:name)).to include('Wesley')
    end

    it 'fill in with number "5" ' do
      get :search_profiles, params: {query: '5'}
      expect(response).to render_template('search_profiles')
      expect(assigns(:profiles).pluck(:name)).to include('Wesley')
    end

    xit 'fill in with special character "$" ' do
      get :search_profiles, params: {query: '$'}
      expect(response).to render_template('search_profiles')
      expect(assigns(:profiles).pluck(:name)).to include('ED$ON')
    end

    it 'should empty array' do
      get :search_profiles, params: {query: 'wefsdfasfa'}
      expect(response).to render_template('search_profiles')
      expect(assigns(:profiles)).to be_empty
    end
  end
end
