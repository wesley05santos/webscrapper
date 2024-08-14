class SearchController < ApplicationController
  def search_profiles
    @profiles = Profile.search(params[:query])
  end
end
