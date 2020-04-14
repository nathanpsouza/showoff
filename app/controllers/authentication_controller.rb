# frozen_string_literal: true

class AuthenticationController < ApplicationController
  def create
    auth = authentication_client.login(user_params)

    session[:user] = auth[:data][:token] if auth[:status] == :success

    render json: auth, status: :ok
  end

  def destroy
    session.delete(:user)
    redirect_to root_path
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
