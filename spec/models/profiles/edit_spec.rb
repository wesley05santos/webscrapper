require 'rails_helper'

describe 'Profile' do
  let!(:profile){ Profile.create(name: 'Teste 555', url: 'teste555') }
  context '#edit' do
    it 'all data' do
      profile.update!(name: 'Update Profile', url: 'example.updateprofile')
      expect(profile.name).to eq('Update Profile')
      expect(profile.url).to eq('https://github.com/example.updateprofile')
    end

    it 'missing name' do
      expect{profile.update!(name: '', url: 'teste')}.to raise_error(/Name can't be blank/)
    end

    it 'missing url' do
      expect{profile.update!(name: 'Teste', url: '')}.to raise_error(/Url can't be blank/)
    end
  end
end
