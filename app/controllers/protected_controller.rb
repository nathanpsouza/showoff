# frozen_string_literal: true

class ProtectedController < ApplicationController
  before_action :check_access_token

  private
  def check_access_token
    unless access_token
      flash[:error] = 'You must login first'
      redirect_to root_path 
    end
  end
end
