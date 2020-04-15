class RecoverPasswordController < ApplicationController
  def create
    if(user_params[:email].empty?)
      flash[:error] = 'You must provide one email'
      render :new
    else
      result = user_client.reset_password({user: user_params})
      if result[:status] == :success
        flash[:success] = 'You will receive one email with instructions, if the provided one is registered.'
      else
        flash[:success] = 'There is something wrong with password reset. Please, try again later'
      end
      redirect_to root_path
    end
  end
  private
    def user_params
      params.require(:user).permit( :email )
    end

    def user_client
      @client ||= ShowoffApi::Client.user()
    end
end
