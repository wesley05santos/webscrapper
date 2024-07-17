require 'rails_helper'

describe Profile do
  let!(:subject) { described_class.create(name: 'Teste 555', url: 'teste555') }
  context '#destroy' do
    it 'erases profile' do
      subject.destroy!
      expect(described_class.all).to be_blank
    end
  end
end
