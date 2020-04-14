class ApplicationController < ActionController::Base
  def credentials
    session[:user]
  end
end
