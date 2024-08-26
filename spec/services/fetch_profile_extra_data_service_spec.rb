require 'rails_helper'

describe FetchProfileExtraDataService do
  let!(:profile) { Profile.create(name: 'Wesley', url: 'wesley05santos') }

  context '#initialize' do
    it 'receives the correct id' do
      new_service = FetchProfileExtraDataService.new(profile.id)
      expect(new_service.instance_variable_get(:@profile_id)).to eq(profile.id)
    end
  end

  context '.call' do
    it "it's call?" do
      expect(FetchProfileExtraDataService.call(profile.id)).to be_truthy
    end
  end

  context '.run' do
    it "it's run?" do
      expect(FetchProfileExtraDataService.new(profile.id).send(:run)).to be_truthy
      expect_any_instance_of(FetchProfileExtraDataService).to receive(:run).with(no_args).and_return(true)
      FetchProfileExtraDataService.call(profile.id)
    end
  end
end
