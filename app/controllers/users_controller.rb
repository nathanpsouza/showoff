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

  private
    def user_params
      params.require(:user).permit(
        :email, :first_name, :last_name, :password, :password_confirmation
      )
    end

    def user_client
      @client ||= ShowoffApi::Client.user
    end

end
