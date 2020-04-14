# frozen_string_literal: true

class ApplicationController < ActionController::Base
  def credentials
    session[:user]
  end
end
