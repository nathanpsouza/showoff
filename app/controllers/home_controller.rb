class HomeController < ApplicationController
  def index
    response = widget_client.visible(params[:term])
    @term = params[:term]
    @widgets = response[:data][:widgets]
  end

  private
    def widget_client
      @client ||= ShowoffApi::Client.visible_widget
    end
end
