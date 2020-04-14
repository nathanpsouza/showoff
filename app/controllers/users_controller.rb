# frozen_string_literal: true

class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.valid?
      user_client.save(@user)
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
    user_attributes = session[:user]
    attributes = ['id', 'first_name', 'last_name', 'email']
    @user = User.new(user_attributes.slice(*attributes))
  end

  def update
    @user = User.new(user_params)
    if @user.valid?
      result = user_client.update(@user)
      session[:user] = result[:data][:user]
      redirect_to root_path
    else
      render :new
    end
  end

  private
    def user_params
      params.require(:user).permit(
        :email, :first_name, :last_name, :password, :password_confirmation
      )
    end

    def user_client
      @client ||= ShowoffApi::Client.user(access_token)
    end
end
