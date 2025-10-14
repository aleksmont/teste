class HomeController < ApplicationController

  def index
    @profile = Profile.new

    # Scraper::search(params[:q])

  end
end
