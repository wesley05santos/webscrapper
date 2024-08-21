require 'rails_helper'

describe 'Profile' do
  before(:each){ Profile.create(name: 'Wesley', url: 'wesley05santos') }
  context '#create' do
    it 'all data' do
      expect(Profile.first&.name).to eq('Wesley')
      expect(Profile.first&.url).to eq('https://github.com/wesley05santos')
    end

    it 'missing name' do
      expect{Profile.create!(name: '', url: 'wesley05santos')}.to raise_error(/Name can't be blank/)
    end

    it 'missing url' do
      expect{Profile.create!(name: 'Wesley', url: '')}.to raise_error(/Url can't be blank/)
    end

    it 'URL invalid' do
      expect{Profile.create!(name: 'Wesley', url: 'sfvnasjgbhiusabnfdvhagikbyhs')}.to raise_error(/Url invalid/)
    end
  end
end
