require 'rails_helper'

describe 'Profile' do
  let(:profile){ Profile.create(name: 'Teste 555', url: 'teste555') }
  context '#create' do
    it 'all data' do
      expect(profile.name).to eq('Teste 555')
      expect(profile.url).to eq('https://github.com/teste555')
    end

    it 'missing name' do
      expect{Profile.create!(name: '', url: 'teste555')}.to raise_error(/Name can't be blank/)
    end

    it 'missing url' do
      expect{Profile.create!(name: 'Teste 555', url: '')}.to raise_error(/Url can't be blank/)
    end
  end
end
