class AuthController < ApplicationController

  def login
  end

  def authenticate
    begin
      user = User.find_by(email: authenticate_params[:email])

      if user.authenticate(authenticate_params[:password])
        # revoke all other sessions
        revoke_sessions(user.id)

        ip_address = request.remote_ip
        user_session = UserSession.new(user_id: user.id, ip_address: ip_address)

        ip_info = IpHelper::get_info(ip_address)

        if ip_info[:success]
          user_session.city = ip_info[:city]
          user_session.state = ip_info[:state]
          user_session.country = ip_info[:country]
        end

        user_session.save!

        session[:current_user_id] = user.id

        redirect_to root_path, notice: "Login was successfully."
      else
        flash[:alert] = "Password is incorrect."
        redirect_to '/auth/login'
      end
    rescue StandardError => e
      redirect_to '/auth/login', notice: "Login unsuccessful."
    end
  end

  def logout
    begin
      revoke_sessions(session[:current_user_id])
      session[:current_user_id] = nil
      redirect_to '/auth/login', notice: "Logout successful."
    rescue StandardError => e
      redirect_to action: '/auth/login', notice: "Session not found."
    end
  end

  def revoke_sessions(user_id)
    UserSession.where(user_id: user_id).update(revoked: true)
  end

  def authenticate_params
    params.require(:session).permit(:email, :password)
  end
end
