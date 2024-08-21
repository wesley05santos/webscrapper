require 'rails_helper'

describe 'Profile' do
  let!(:profile){ Profile.create(name: 'Wesley', url: 'wesley05santos') }
  context '#edit' do
    it 'all data' do
      profile.update!(name: 'Xita', url: 'xitarps')
      expect(profile.name).to eq('Xita')
      expect(profile.url).to eq('https://github.com/xitarps')
    end

    it 'missing name' do
      expect{profile.update!(name: '', url: 'xitarps')}.to raise_error(/Name can't be blank/)
    end

    it 'missing url' do
      expect{profile.update!(name: 'Xita', url: '')}.to raise_error(/Url can't be blank/)
    end
  end
end
