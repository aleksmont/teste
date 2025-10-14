class HomeController < ApplicationController

  def index
    q = Profile
    if params[:search]
      q = q.where("concat_ws(' ', profiles.name, profiles.github_username, profiles.github_organization, profiles.github_location) ILIKE ?", "%#{params[:search]}%")
    end

    @profiles = q
                  .page(params[:page] || 1)
                  .per(params[:per_page] || 5)
                  .order(params[:order_by] || "name ASC")
  end
end
