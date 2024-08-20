class FetchProfileExtraDataService
  def initialize(id)
    @profile_id = id
    binding.break
  end

  def self.call(id)
    binding.break
    new(id).call
  end

  def call
    run
  end
  private

  def run
    @profile = Profile.find(@profile_id)
    binding.break
  end
end
