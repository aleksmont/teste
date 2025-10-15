class ProfilesController < ApplicationController

  def index
    if params[:profile_uuid]
      profile = Profile.find_by!(uuid: params[:profile_uuid])
      profile.reload_info
      flash[:notice] = "Informações do Perfil #{profile.name} recarregados com sucesso"
    end

    @profiles = Profile
                  .page(params[:page] || 1)
                  .per(params[:per_page] || 5)
                  .order(params[:order_by] || "name ASC")
  end

  def show
    @profile = Profile.find_by!(uuid: params[:uuid])
  end

  def edit
    @profile = Profile.find_by!(uuid: params[:uuid])
  end

  def new
    @profile = Profile.new
  end

  def create
    begin
      Profile.create!(profile_params)
      redirect_to profiles_path, notice: "Profile criado com sucesso."
    rescue StandardError => e
      puts e.message
      redirect_to root_path, alert: "Atenção, não conseguimos criar o perfil com as informações inseridas."
    end
  end

  def update
    begin
      @profile = Profile.find(params[:uuid])
      @profile.update(profile_params)
      redirect_to root_path, notice: "Perfil atualizado com sucesso!"
    rescue StandardError => e
      puts e.message
      redirect_to root_path, alert: "Atenção, não conseguimos editar o perfil."
    end
  end

  def destroy
    begin
      @profile = Profile.find_by!(uuid: params[:uuid])
      @profile.destroy
      redirect_to root_path, notice: "Profile excluido com sucesso."
    rescue StandardError => e
      puts e.message
      redirect_to root_path, alert: "Atenção, não conseguimos excluir o perfil."
    end
  end

  private

  def profile_params
    params.require(:profile).permit(:name, :github_url)
  end
end
