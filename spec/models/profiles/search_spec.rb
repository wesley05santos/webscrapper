require 'rails_helper'

describe 'Profile' do
  before(:each) do
    Profile.create(name: 'Wesley', url: 'https://github.com/wesley05santos')
    Profile.create(name: 'Xita', url: 'https://github.com/xitarps')
    Profile.create(name: 'Matz-x', url: 'https://github.com/matz')
  end

  context '.search' do
    it 'all data' do
      expect(Profile.search('x').pluck(:name)).to include('Xita', 'Matz-x')
    end
  end
end
