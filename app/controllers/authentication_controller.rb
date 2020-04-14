class AuthenticationController < ApplicationController
  def create

    auth = authentication_client.login(user_params)
    
    render json: auth, status: :ok
  end

  private
    def user_params
      params.require(:user).permit(
        :email, :password
      )
    end

    def authentication_client
      @client ||= ShowoffApi::Client.authentication
    end
end
