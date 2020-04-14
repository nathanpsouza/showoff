# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :load_user_data
  
  def access_token
    session[:auth] ? session[:auth]['access_token'] : nil
  end

  private
  def load_user_data
    if access_token && session[:user].nil?
      client = ShowoffApi::Client.user(access_token)
      session[:user] = client.me[:data][:user]
    end
  end
end
