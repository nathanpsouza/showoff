# frozen_string_literal: true

class AuthenticationController < ApplicationController
  def create
    auth = authentication_client.login(user_params)

    session[:auth] = auth[:data][:token] if auth[:status] == :success

    render json: auth, status: status_for(auth[:status])
  end

  def destroy
    session.delete(:auth)
    session.delete(:user)
    redirect_to root_path
  end

  private
    def user_params
      params.require(:user).permit(
        :email, :password
      )
    end

    def status_for result
      result == :success ? :ok : :unprocessable_entity
    end

    def authentication_client
      @client ||= ShowoffApi::Client.authentication
    end
end
