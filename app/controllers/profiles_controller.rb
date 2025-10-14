class ProfilesController < ApplicationController

  def index
    if params[:profile_uuid]
      Profile.find_by!(uuid: params[:profile_uuid]).reload_info
    end

    @profiles = Profile.order(:id)
  end

  def create
    begin
      Profile.create!(profile_params)
      redirect_to root_path, notice: "User was successfully created."
    rescue StandardError => e
      puts e
      puts e.message
      redirect_to root_path, notice: "errr."
    end
  end

  private

  def profile_params
    params.require(:profile).permit(:name, :github_url)
  end
end
